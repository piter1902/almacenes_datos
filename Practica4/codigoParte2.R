library("geosphere")
require(glmnet)

# Función que proporciona un perc % de los datos del dataset
sampledataset = function(dataset, perc=1) { 
  loc.data.2 = dataset
  if (perc != 1) {
    ind.sample = sample(1:nrow(loc.data.2), perc*nrow(loc.data.2))
    loc.data.2 = loc.data.2[ind.sample,]
  }
  return(loc.data.2) 
}

# Calcula el punto de intersección de las rectas
getPunto <- function (model, l) {
  a = -1/coef(model)[2]
  b = -coef(model)[1]/coef(model)[2]
  y = (b-l[2]) / (l[1]-a)
  x =  a*y + b
  return(c(x,y))
}

# Devuelve los elementos a y b de la ecuación de la recta y = ax + b
recta <- function(dataset) {
  maxy = dataset[dataset$latitud.y == max(dataset$latitud.y),]
  miny = dataset[dataset$latitud.y == min(dataset$latitud.y),]
  # y = ax + b
  a = (maxy$latitud.y - miny$latitud.y) / (maxy$longitud.x - miny$longitud.x)
  b = maxy$latitud.y - (a * maxy$longitud.x)
  return(c(a, b))
}

# Devuelve las probabilidades de las calas en forma de vector
calcularProbCala <- function(coordX, coordY, modeloNum1, modeloNum2) {
  # Calcular el nuevo data frame
  new.data = data.frame(
    longitud.x = coordX,
    latitud.y  = coordY,
    cala       = 0
  )
  # Calculo del modelo de regresion logistica
  p1 = predict(modeloNum1, newdata = new.data, type = "response")
  p2 = predict(modeloNum2, newdata = new.data, type = "response")
  
  coeficienteP0 = p1 / (1-p1)
  coeficienteP2 = p2 / (1-p2)
  pCala0 = coeficienteP0 / (1 + coeficienteP0 + coeficienteP2)
  pCala2 = coeficienteP2 / (1 + coeficienteP0 + coeficienteP2)
  pCala1 = 1 - (pCala0 + pCala2)
  # Devolvemos el vector de soluciones
  return(c(pCala0, pCala1, pCala2))
}

# Funcion que devuelve una cala en función de unas coordenadas GPS
calcularCala <- function(coordX, coordY, modeloNum1, modeloNum2) {
  # Usando la función anterior
  vector = calcularProbCala(coordX, coordY, modeloNum1, modeloNum2)
  if (max(vector) == vector[1]) {        return(0)
  } else if(max(vector) == vector[2]) {  return(1)
  } else {                               return(2)
  }
}

# Calcula el número de aciertos del set
aciertosCala <- function(listaPuntos, modeloNum1, modeloNum2) {
  aciertos <- 0
  for(i in 1:nrow(listaPuntos)){
    datoIndv = listaPuntos[i,]
    resp = calcularCala(datoIndv["longitud.x"], datoIndv["latitud.y"], modeloNum1, modeloNum2)
    if(resp == datoIndv["cala"]){
      aciertos <- aciertos + 1
    }
  }
  return(aciertos/nrow(listaPuntos))
}  

# Cargar el dataset
fardos.data = read.csv("Desktop/almacenes_datos/Practica4/datacala.csv")
fardos.full = fardos.data
fardos.data$X = NULL
# Calculo de la recta (y=ax+b)
l = recta(fardos.data)
# Utilizando una regresión logística
fardos.data.1 = fardos.data
fardos.data.2 = fardos.data
# Los 1 apuntan al centro
fardos.data.1$cala = ifelse(fardos.data$cala == 0, 1, 0)
fardos.data.2$cala = ifelse(fardos.data$cala == 2, 1, 0)
# Se puede ignorar uno de ellos porque son combinaciones lineales (rectas)
fardos.model1 = glm(cala~latitud.y, data = fardos.data.1, family = binomial)
fardos.model2 = glm(cala~latitud.y, data = fardos.data.2, family = binomial)
# Rectas de división de la playa (están en función de y) -> Ponerlos en f(x)
p1Todos = getPunto(fardos.model1, l)
p2Todos = getPunto(fardos.model2, l)
p1Todos = unlist(p1Todos)
p2Todos = unlist(p2Todos)

# Primer porcentaje con 600 fardos
initPercentage = aciertosCala(fardos.full, fardos.model1, fardos.model2)

# Cálculo del bucle
pv <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)
for (p in pv) {
  # Listas con el punto norte y sur
  lista = c()
  lista2 = c()
  porcentajes = c()
  i <- 1
  for (j in 1:1000) {
    dataset = sampledataset(fardos.data, p)
    dataset1 = dataset
    dataset2 = dataset
    
    dataset1$cala = ifelse(dataset$cala == 0, 1, 0)
    dataset2$cala = ifelse(dataset$cala == 2, 1, 0)
    # Calcular las regresiones
    model1 = glm(cala~latitud.y, data = dataset1, family = binomial)
    model2 = glm(cala~latitud.y, data = dataset2, family = binomial)
    # Calculo del primer punto
    p1 = getPunto(model1, l)
    # Calculo del segundo punto
    p2 = getPunto(model2, l)
    
    # Guarda los puntos y los porcentajes
    porcentajes[[i]] <- aciertosCala(fardos.full, model1, model2)
    lista[[i]] <- p1
    lista2[[i]] <- p2
    i <- i + 1
  }
  
  # Calcula las distancias en metros entre los puntos
  distancias1 = c()
  distancias2 = c()
  i <- 1
  for (j in 1:1000) {
    distancias1[[i]] <- distHaversine(unlist(lista[i]), p1Todos)
    distancias2[[i]] <- distHaversine(unlist(lista2[i]), p2Todos)
    i <- i + 1
  }
  
  # Elige las 100 peores distancias
  distancias1[order(distancias1, decreasing=TRUE)][1:100]
  distancias2[order(distancias2, decreasing=TRUE)][1:100]
  porcentajes[order(porcentajes, decreasing=FALSE)][1:100]
  porcentajeAVG=mean(porcentajes)
  porcentajeAVG=abs(porcentajeAVG - initPercentage)
  print(porcentajeAVG)
  if((mean(distancias1) < 100 & mean(distancias2) < 100) | porcentajeAVG < 0.01) {
    cat("Se podría haber hecho con", p*600, "fardos.\n")
  } else {
    cat("No se podría haber hecho con", p*600, "fardos.\n")
  }
  cat("Media de las peores distancias del primer punto de separación: ", mean(distancias1), "\n")
  cat("Media de las peores distancias del segundo punto de separación: ", mean(distancias2), "\n")
  cat("Media de los peores porcentajes de acierto: ", mean(porcentajes), "\n")
}

