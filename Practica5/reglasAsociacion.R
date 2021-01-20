library(arules)


vuelos.data = read.csv("/home/cris/Escritorio/Universidad/almacenes_datos/Practica5/vuelosReglas.csv")
vuelos.data = vuelos.data[!duplicated(vuelos.data),]

ind.sample = sample(1:nrow(vuelos.data), nrow(vuelos.data))
vuelos.data = vuelos.data[ind.sample,]

#Paso a factores las variables cualitativas

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

#Grupos con el retraso
vuelos.data$TIEMPODERETRASOLLEGADA = cut(vuelos.data$TIEMPODERETRASOLLEGADA, breaks = c(0,10,20,30,40,50,60,200), labels = c("Hasta10", "Hasta20", "Hasta30", "Hasta40", "Hasta50", "Hasta1hora", "Más1hora"))


hora.data = read.csv("/home/cris/Escritorio/Universidad/almacenes_datos/Practica5/horaReglas.csv")

# Para acceder a la franja de un elemento: subset(hora.data.franja, IDHORA == 3)$franja
# Combinación de los datos de franjas y vuelos
print("Juntando los conjuntos de datos")
vuelos.data.franjas = merge(x = vuelos.data, y = hora.data, by.x = "IDHORASALIDAREAL", by.y = "IDHORA")

vuelos.data.franjas$IDHORASALIDAREAL <- NULL 
vuelos.data.franjas$IDHORALLEGADAREAL <- NULL 
vuelos.data.franjas$HORAMINUTOS24HORAS = cut(vuelos.data.franjas$HORAMINUTOS24HORAS, breaks = c(700,1400,2000, 699), labels = c("Mañana", "Tarde", "Noche"))


#Transacciones
vuelos_transc = as(vuelos.data.franjas, "transactions")


#Apriori

soporte1 = apriori(vuelos_transc, 
                   parameter = list(support = 0, confidence = 0, maxlen = 1, target = "frequent itemsets"))
#ordenar por soporte
soporte1 = sort(soporte1, by = "support")
#guardar en vector los soportes de itemsets con 1 item
val_soporte1 = quality(soporte1)$support

#ordenar val_soporte1, buscar mediana o Q1, Q3,... o 
#lo que se considere adecuado para obtener un minsup
print(summary(val_soporte1))




#generar reglas con minsup = 0.01, minconf = 0.8 y reglas contienen a lo sumo 10 items
vuelos_reglas_a = apriori(vuelos_transc,
                          parameter = list(support = 0.00005, confidence = 0.5, maxlen = 10))

#resumen de las reglas generadas
print(summary(vuelos_reglas_a))
#total de reglas generadas
print(length(vuelos_reglas_a))


reglasApriori1 = subset(vuelos_reglas_a, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasApriori1))
inspect(head(sort(reglasApriori1, by = "confidence"), 10)) 
vuelos_reglas_a = apriori(vuelos_transc,
                          parameter = list(support = 0.00005, confidence = 0.6, maxlen = 4)) 
reglasApriori1 = subset(vuelos_reglas_a, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasApriori1))
inspect(head(sort(reglasApriori1, by = "support"), 10)) 
vuelos_reglas_a = apriori(vuelos_transc,
                          parameter = list(support = 0.00002, confidence = 0.6, maxlen = 4))
reglasApriori1 = subset(vuelos_reglas_a, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasApriori1))
inspect(head(sort(reglasApriori1, by = "support"), 10)) 

#Reglas con eclat
#Crear itemsets frecuentes minsup = 0.0001, reglas cotienen a lo sumo 10 items
itemsets_frec_e = eclat(vuelos_transc,
                        parameter = list(support = 0.0001, maxlen = 10))
#Generar reglas con los itemsets frecuentes, minconf = 0.8
vuelo_reglas_e = ruleInduction(itemsets_frec_e, vuelos_transc, confidence = 0.6)
reglasEclay = subset(vuelo_reglas_e, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasEclay))
inspect(head(sort(reglasEclay, by = "support"), 10)) 


itemsets_frec_e = eclat(vuelos_transc,
                        parameter = list(support = 0.00005, maxlen = 4))
#Generar reglas con los itemsets frecuentes, minconf = 0.8
vuelo_reglas_e = ruleInduction(itemsets_frec_e, vuelos_transc, confidence = 0.6)
reglasEclay = subset(vuelo_reglas_e, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasEclay))
inspect(head(sort(reglasEclay, by = "support"), 10)) 

#Reglas con itemsets frecuentes maximales y cerrados
#generar itemsets frecuentes maximales con apriori
maximales_a = apriori(vuelos_transc,
                      parameter = list(support = 0.00005, target = "maximally frequent itemsets"))
#generar itemsets frecuentes cerrados con apriori
cerrados_a = apriori(vuelos_transc,
                     parameter = list(support = 0.00005, target = "closed frequent itemsets"))
#Con eclat: lo mismo sustituyendo apriori -> eclat

#generar reglas con itemsets generados anteriormente
reglas_maximales = ruleInduction(maximales_a, vuelos_transc, confidence = 0.6)
reglasFyC = subset(reglas_maximales, rhs %pin% c("TIEMPODERETRASOLLEGADA"))
print(length(reglasFyC))
inspect(head(sort(reglasFyC, by = "support"), 10)) 







