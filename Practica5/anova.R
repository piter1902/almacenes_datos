vuelos.data = read.csv("/home/cris/Escritorio/Universidad/almacenes_datos/Practica5/vuelosReglas.csv")
vuelos.data = vuelos.data[!duplicated(vuelos.data),]

# Variables cualitativas
vuelos.data$IDHORASALIDAREAL = as.factor(vuelos.data$IDHORASALIDAREAL)
vuelos.data$IDFECHASALIDA = as.factor(vuelos.data$IDFECHASALIDA)
vuelos.data$IDAVION = as.factor(vuelos.data$IDAVION)
vuelos.data$IDFECHALLEGADA = as.factor(vuelos.data$IDFECHALLEGADA)
vuelos.data$IDHORALLEGADAREAL = as.factor(vuelos.data$IDHORALLEGADAREAL)
vuelos.data$IDAEROLINEA = as.factor(vuelos.data$IDAEROLINEA)
vuelos.data$IDAEROPUERTODESTINO = as.factor(vuelos.data$IDAEROPUERTODESTINO)
vuelos.data$IDAEROPUERTOORIGEN = as.factor(vuelos.data$IDAEROPUERTOORIGEN)
vuelos.data$IDOPERADORA = as.factor(vuelos.data$IDOPERADORA)
#vuelos.data$NUMEROVUELO = as.factor(vuelos.data$NUMEROVUELO)

# División de las horas en franjas horarias
# 3 franjas horarias -> m,t,n
# m = [7:00, 15:00)
# t = [15:00, 24:00)
# n = [24:00, 7:00)
hora.data = read.csv("/home/cris/Escritorio/Universidad/almacenes_datos/Practica5/hora.csv")
franja = c()
for(i in 1:nrow(hora.data)) {
    hora = as.numeric(unlist(strsplit(hora.data[i,]$HORAMINUTOS24HORAS, ":"))[1])
    # h =  as.numeric(unlist(strsplit(hora.data[i,]$HORAMINUTOS24HORAS, ":"))[1])
    if(hora >= 7 & hora < 15) {
        franja[i] = "M"
    } else if(hora >= 15 & hora < 24) {
        franja[i] = "T"
    } else {
        franja[i] = "N"
    }
}
# Esto se puede hacer porque están ordenados
hora.data.franja = cbind(hora.data, franja)

# Para acceder a la franja de un elemento: subset(hora.data.franja, IDHORA == 3)$franja
# Combinación de los datos de franjas y vuelos
print("Juntando los conjuntos de datos")
vuelos.data.franjas = merge(x = vuelos.data, y = hora.data.franja, by.x = "IDHORASALIDAREAL", by.y = "IDHORA")
vuelos.data.franjas$franja = as.factor(vuelos.data.franjas$franja)

print("Calculando el modelo de regrsión lineal")
modelo = lm(TIEMPODERETRASOLLEGADA~franja, data = vuelos.data.franjas)
aov = aov(TIEMPODERETRASOLLEGADA~franja, data = vuelos.data.franjas)
print(summary(modelo))
print("-----------------")
print(summary(aov))
print("-----------------")
# Test de Tukey
tukey = TukeyHSD(aov)
print(tukey)

# Boxplot de medias del test
plot(tukey)