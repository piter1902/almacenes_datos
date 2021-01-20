# Devuelve los elementos a y b de la ecuación de la recta y = ax + b
recta <- function(dataset) {
  maxy = dataset[dataset$latitud.y == max(dataset$latitud.y),]
  miny = dataset[dataset$latitud.y == min(dataset$latitud.y),]
  # y = ax + b
  a = (maxy$latitud.y - miny$latitud.y) / (maxy$longitud.x - miny$longitud.x)
  b = maxy$latitud.y - (a * maxy$longitud.x)
  return(c(a, b))
}

# Calcula el punto de intersección de las rectas
getPunto <- function (model, l) {
  a = -1/coef(model)[2]
  b = -coef(model)[1]/coef(model)[2]
  y = (b-l[2]) / (l[1]-a)
  x =  a*y + b
  return(c(x,y))
}

# Devuelve las probabilidades de las calas en forma de vector
calcularProbCala <- function(coordX, coordY) {
  # Calcular el nuevo data frame
  new.data = data.frame(
    longitud.x = coordX,
    latitud.y  = coordY,
    cala       = 0
  )
  # Calculo del modelo de regresion logistica
  p1 = predict(fardos.model1, newdata = new.data, type = "response")
  p2 = predict(fardos.model2, newdata = new.data, type = "response")
  # Normalizar probabilidades
  pCala0 = p1
  pCala2 = p2
  pCala1 = 1 - (pCala0 + pCala2)
  # Devolvemos el vector de soluciones
  return(c(pCala0, pCala1, pCala2))
}

calcularProbCalaMatriz <- function(coordX, coordY) {
  # Calcular el nuevo data frame
  new.data = data.frame(
    longitud.x = coordX,
    latitud.y  = coordY,
    cala       = 0
  )
  # Calculo del modelo de regresion logistica
  fardos.model1 = glm(cala~latitud.y, data = fardos.data.1.test, family = binomial)
  fardos.model2 = glm(cala~latitud.y, data = fardos.data.2.test, family = binomial)
  p1 = predict(fardos.model1, newdata = new.data, type = "response")
  p2 = predict(fardos.model2, newdata = new.data, type = "response")
  # Normalizar probabilidades
  pCala0 = p1
  pCala2 = p2
  pCala1 = 1 - (pCala0 + pCala2)
  # Devolvemos el vector de soluciones
  return(c(pCala0, pCala1, pCala2))
}

# Funcion que devuelve una cala en función de unas coordenadas GPS
calcularCala <- function(coordX, coordY) {
  # Usando la función anterior
  vector = calcularProbCala(coordX, coordY)
  if (max(vector) == vector[1]) {
    # Es cala 0
    return("Cala 0")
  } else if(max(vector) == vector[2]) {
    # Es cala 1
    return("Cala 1")
  } else {
    # Es cala 2
    return("Cala 2")
  }
}

calcularCalaMatriz <- function(coordX, coordY) {
  # Usando la función anterior
  vector = calcularProbCalaMatriz(coordX, coordY)
  if (max(vector) == vector[1]) {
    # Es cala 0
    return(0)
  } else if(max(vector) == vector[2]) {
    # Es cala 1
    return(1)
  } else {
    # Es cala 2
    return(2)
  }
}

matrizConfusion <-function(fardos.data.train){
  
  matrizConf <- vector("double", length(fardos.data.train$longitud.x))  # 1. output
  for (i in seq_along(fardos.data.train$longitud.x)) {            # 2. secuencia
    matrizConf[[i]] <- calcularCalaMatriz(fardos.data.train$longitud.x[[i]], fardos.data.train$latitud.y[[i]])     # 3. cuerpo
  }
  
  #test.clas<-calcularCalaMatriz(fardos.data.train$longitud.x, fardos.data.train$latitud.y)
  return(table(matrizConf, fardos.data.train$cala))
}

# Lectura del fichero de fardos
fardos.data = read.csv("/home/cris/Escritorio/Universidad/almacenes_datos/Practica4/datacala.csv")
fardos.data$X = NULL
# Creación del plot de la playa
plot(fardos.data$longitud.x, fardos.data$latitud.y, 
     xlab = "Longitud", ylab = "Latitud",
     col = ifelse(fardos.data$cala == 0, "red", ifelse(fardos.data$cala == 1, "blue", "green")))
# Calculo de la recta (y=ax+b)
rectaPlaya = recta(fardos.data)
# Primer argumento -> intercept, segundo argumento -> slope
abline(rectaPlaya[2], rectaPlaya[1])
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
a1 = 1/coef(fardos.model1)[2]
b1 = -coef(fardos.model1)[1]/coef(fardos.model1)[2]
a2 = 1/coef(fardos.model2)[2]
b2 = -coef(fardos.model2)[1]/coef(fardos.model2)[2]
# Rectas
abline(b1, -a1, col = "red")
abline(b2, -a2, col = "steelblue")
# Calculo de los puntos de intersección
punto1 = getPunto(fardos.model1, rectaPlaya)
punto2 = getPunto(fardos.model2, rectaPlaya)
# Imprimir los puntos de intersección de la playa
cat("El punto al norte es: (", punto1[2], ", ", punto1[1],")\n")
cat("El punto al sur es: (", punto2[2], ", ", punto2[1],")\n")

#Matriz de confusión 
fardos.train =sample(1:nrow(fardos.data), 0.8*nrow(fardos.data))
fardos.data.test=fardos.data[fardos.train ,]
fardos.data.train =fardos.data[-fardos.train ,]
fardos.data.1.test=fardos.data.test
fardos.data.2.test=fardos.data.test

fardos.data.1.test$cala = ifelse(fardos.data.test$cala == 0, 1, 0)
fardos.data.2.test$cala = ifelse(fardos.data.test$cala == 2, 1, 0)
confusion=matrizConfusion(fardos.data.train)
cat("La matriz de confusión de este modelo es:")
print(confusion)


# Cálculo de los puntos
#Primero (9,558359, 1,1)
cprimero=calcularCala(9.558359, 1.1)
pprimero=calcularProbCala(9.558359, 1.1)
cat("El primero de los fardos llegara a la cala: ", cprimero, ". Con una probabilidad de: (", pprimero, ") para cada cala.\n")
#segundo (9,564329, 1,089)
csegundo=calcularCala(9.564329, 1.089)
psegundo=calcularProbCala(9.564329, 1.089)
cat("El tercero de los fardos llegara a la cala: ", csegundo, ". Con una probabilidad de: (", psegundo, ") para cada cala.\n")
#tercero (9,568671, 1,081)
ctercero=calcularCala(9.568671, 1.081)
ptercero=calcularProbCala(9.568671, 1.081)
cat("El tercero de los fardos llegara a la cala: ", ctercero, ". Con una probabilidad de: (", ptercero, ") para cada cala.\n")









