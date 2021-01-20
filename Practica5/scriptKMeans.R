vuelos.data = read.csv("~/Desktop/almacenes_datos/Practica5/todosDatos.csv")




vuelos.data.aero.origen = vuelos.data["IDAEROORIGEN"]
vuelos.data.aero.origen$TIEMPODERETRASOLLEGADA = vuelos.data["TIEMPODERETRASOLLEGADA"]
vuelos.data.aero.origen$IDAEROORIGEN = as.factor(vuelos.data$IDAEROORIGEN)
X <- data.frame(vuelos.data.aero.origen)
average <- aggregate(x = X$TIEMPODERETRASOLLEGADA, by = list(unique.values = X$IDAEROORIGEN), FUN = mean)
colnames(average)[2] <- "RETRASO_LLEGADA_AVG"
colnames(average)[1] <- "IDAEROORIGEN"
vdao = average
km.out.or = kmeans(vdao[,2],  centers  =3,  nstart  = 50)
plot(vdao$RETRASO_LLEGADA_AVG, vdao$RETRASO_LLEGADA_AVG,  main = "En función del aeropuerto de origen",
     ylim=c(min(vdao$RETRASO_LLEGADA_AVG), max(vdao$RETRASO_LLEGADA_AVG)+10),
     ylab="Retraso a la llegada", xlab="Retraso a la llegada",
     pch = 20, col = km.out.or$cluster)
points(x = km.out.or$centers, y = km.out.or$centers, type = "p", col=c("#0000FF"))
text( x = vdao[,2], y = vdao[,2],  labels=vdao[,1] ,cex  = 0.35, pos= 3, col=km.out.or$cluster)




vuelos.data.aero.destino = vuelos.data["IDAERODESTINO"]
vuelos.data.aero.destino$TIEMPODERETRASOLLEGADA = vuelos.data["TIEMPODERETRASOLLEGADA"]
vuelos.data.aero.destino$IDAERODESTINO = as.factor(vuelos.data$IDAERODESTINO)
X <- data.frame(vuelos.data.aero.destino)
average <- aggregate(x = X$TIEMPODERETRASOLLEGADA, by = list(unique.values = X$IDAERODESTINO), FUN = mean)
colnames(average)[2] <- "RETRASO_LLEGADA_AVG"
colnames(average)[1] <- "IDAERODESTINO"
vdad = average
km.out.dest = kmeans(vdad[,2],  centers  =3,  nstart  = 50)
plot(vdad$RETRASO_LLEGADA_AVG, vdad$RETRASO_LLEGADA_AVG, main = "En función del aeropuerto de destino",
     ylim=c(min(vdad$RETRASO_LLEGADA_AVG), max(vdad$RETRASO_LLEGADA_AVG)+10),
     ylab="Retraso a la llegada", xlab="Retraso a la llegada",
     pch = 20, col = km.out.dest$cluster)
points(x = km.out.dest$centers, y = km.out.dest$centers, type = "p", col=c("#0000FF"))
text(x = vdad[,2], y = vdad[,2], labels=vdad[,1] ,cex  = 0.35, pos= 3, col=km.out.dest$cluster)




vuelos.data.aerolinea = vuelos.data["IDAEROLINEA"]
vuelos.data.aerolinea$TIEMPODERETRASOLLEGADA = vuelos.data["TIEMPODERETRASOLLEGADA"]
vuelos.data.aerolinea$IDAEROLINEA = as.factor(vuelos.data$IDAEROLINEA)
X <- data.frame(vuelos.data.aerolinea)
average <- aggregate(x = X$TIEMPODERETRASOLLEGADA, by = list(unique.values = X$IDAEROLINEA), FUN = mean)
colnames(average)[2] <- "RETRASO_LLEGADA_AVG"
colnames(average)[1] <- "IDAEROLINEA"
aerolinea = average
km.out.aerolinea = kmeans(aerolinea[,2],  centers  =3,  nstart  = 50)
plot(aerolinea$RETRASO_LLEGADA_AVG, aerolinea$RETRASO_LLEGADA_AVG,  main = "En función de la aerolínea",
     ylim=c(min(aerolinea$RETRASO_LLEGADA_AVG), max(aerolinea$RETRASO_LLEGADA_AVG)+10),
     ylab="Retraso a la llegada", xlab="Retraso a la llegada",
     pch = 20, col = km.out.aerolinea$cluster)
points(x = km.out.aerolinea$centers, y = km.out.aerolinea$centers, type = "p", col=c("#0000FF"))
text(x = aerolinea[,2], y = aerolinea[,2], labels=aerolinea[,1] ,cex  = 0.35, pos= 3, col=km.out.aerolinea$cluster)




vuelos.data.codigo = vuelos.data["MATRICULAAVION"]
vuelos.data.codigo$TIEMPODERETRASOLLEGADA = vuelos.data["TIEMPODERETRASOLLEGADA"]
vuelos.data.codigo$MATRICULAAVION = as.factor(vuelos.data$MATRICULAAVION)
X <- data.frame(vuelos.data.codigo)
average <- aggregate(x = X$TIEMPODERETRASOLLEGADA, by = list(unique.values = X$MATRICULAAVION), FUN = mean)
colnames(average)[2] <- "RETRASO_LLEGADA_AVG"
colnames(average)[1] <- "MATRICULA_AVION"
model.code = average
km.out.code = kmeans(model.code[,2],  centers  =3,  nstart  = 50)
plot(model.code$RETRASO_LLEGADA_AVG, model.code$RETRASO_LLEGADA_AVG, main = "En función de la matrícula del avión",
     ylim=c(min(model.code$RETRASO_LLEGADA_AVG), max(model.code$RETRASO_LLEGADA_AVG)+10),
     ylab="Retraso a la llegada", xlab="Retraso a la llegada",
     pch = 20, col = km.out.code$cluster)
points(x = km.out.code$centers, y = km.out.code$centers, type = "p", col=c("#0000FF"))
text(x = model.code[,2], y = model.code[,2], labels=model.code[,1] ,cex  = 0.35, pos= 3, col=km.out.code$cluster)

