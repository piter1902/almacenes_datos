vuelos.data = read.csv("Desktop/almacenes_datos/Practica5/vuelos.csv")
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
vuelos.data$NUMEROVUELO = as.factor(vuelos.data$NUMEROVUELO)

# Regresión paso a paso
# Calculos con un 30% de los datos
ind.sample = sample(1:nrow(vuelos.data), 0.3*nrow(vuelos.data))
vuelos.data = vuelos.data[ind.sample,]

# Calculo del resto de predictores
totalPredictores <- c("IDHORASALIDAREAL", "IDFECHASALIDA", "IDFECHALLEGADA", "IDHORALLEGADAREAL", "IDAEROLINEA", "IDAEROPUERTODESTINO", "IDAEROPUERTOORIGEN", "IDOPERADORA")
predictores <- c()
mejores <- c()
for(i in 1:length(totalPredictores)) {
    firstTime = TRUE
    maxAdjR2 = 0
    mejorPredictor = ""
    for(j in 1:length(totalPredictores)) {
        # Calculo del modelo con j
        if (!(totalPredictores[j] %in% predictores)) {
            predictoresUnionJ = append(predictores, totalPredictores[j])
            fstr = paste("TIEMPODERETRASOLLEGADA", paste(predictoresUnionJ, collapse="+"), sep="~")
            f <- as.formula(fstr)
            print(cat("Calculando modelo para: ", fstr))
            modelo = lm(f, data = vuelos.data)
            metricaAdjR2 = summary(modelo)$adj.r.squared
            print(cat("adjR2: ", metricaAdjR2))
            if(firstTime | metricaAdjR2 > maxAdjR2) {
                firstTime = FALSE
                maxAdjR2 = metricaAdjR2
                mejorPredictor = totalPredictores[j]
            }
        }
    }
    # maxAdjR2 es el R2 del mejor
    # Guardamos el mejor resultado
    predictores = append(predictores, mejorPredictor)
    print(paste("Lista de predictores: ", paste(predictores, collapse = ",")))
    mejores = append(mejores, maxAdjR2)
}

# Comparacion de los modelos con los distintos predictores
mejorAdjR2 = max(mejores)
print(cat("El mejor adjR2 es: ", mejorAdjR2))
# El mejor modelo tiene match(mejores, mejorAdjR2) predictores
print(predictores)
print(mejores)
