CREATE TABLE Fecha
(
	idFecha					INT,
	descripcionCompletaFecha		VARCHAR(100) NOT NULL,
	nombreDiaSemana			VARCHAR(100) NOT NULL,
	numDiaEnMes				INT NOT NULL,
	nombreMes				VARCHAR(100) NOT NULL,
	numMesEnAño				INT NOT NULL,
	añoMes					VARCHAR(100) NOT NULL,
	cuatrimestre				VARCHAR(100) NOT NULL,
	añoCuatrimestre			VARCHAR(100) NOT NULL,
	indicadorDeFinDeSemana			VARCHAR(100) NOT NULL,
	año					INT NOT NULL,
	PRIMARY KEY(idFecha));


CREATE TABLE Avion
(
	idAvion					INT,
	nombreModeloAvion			VARCHAR(100),
	codigoModeloAvion			VARCHAR(100),
	matriculaAvion				VARCHAR(100) NOT NULL,
	PRIMARY KEY(idAvion));


CREATE TABLE Aeropuerto
(
	idAeropuerto				INT,
	nombreAeropuerto			VARCHAR(100) NOT NULL,
	ciudad					VARCHAR(100) NOT NULL,
	ciudadesConEstado			VARCHAR(100) NOT NULL,
	estado					VARCHAR(100) NOT NULL,
	acronimoEstado				VARCHAR(100) NOT NULL,
	ciudadNumHabitantes			INT NOT NULL,
	ciudadTimeZone				VARCHAR(100) NOT NULL,
	PRIMARY KEY(idAeropuerto));


CREATE TABLE Aerolinea
(
	idAerolinea				INT,
	nombreAerolinea				VARCHAR(100) NOT NULL,
	codigoAerolinea				VARCHAR(100) NOT NULL,
	PRIMARY KEY(idAerolinea));


CREATE TABLE Operadora
(
	idOperadora				INT,
	codigoOperadora				VARCHAR(100) NOT NULL,
	nombreOperadora				VARCHAR(100) NOT NULL,
	PRIMARY KEY(idOperadora));


CREATE TABLE Hora
(
	idHora					INT,
	horaMinutos24Horas			VARCHAR(100) NOT NULL,
	horaMinutosAMPM				VARCHAR(100) NOT NULL,
	indicarAMPM				VARCHAR(100) NOT NULL,
	PRIMARY KEY(idHora));


CREATE TABLE Vuelos
(
	idHoraSalidaReal			INT,
	idFechaSalida				INT,
	idAvion					INT,
	idFechaLlegada				INT NOT NULL,
	idHoraLlegadaReal			INT NOT NULL,
	idAerolinea				INT NOT NULL,
	idAeropuertoDestino			INT NOT NULL,
	idAeropuertoOrigen			INT NOT NULL,
	idOperadora				INT NOT NULL,
	numeroVuelo				VARCHAR(100) NOT NULL,
	tiempoRealVuelo				INT NOT NULL,
	tiempoEstimadoVuelo			INT NOT NULL,
	tiempoDeRetrasoLlegada			INT NOT NULL,
	tiempoDeRetrasoSalida			INT NOT NULL,
	tiempoAdelantadoLlegada			INT NOT NULL,
	PRIMARY KEY(idHoraSalidaReal, idFechaSalida, idAvion),
	FOREIGN KEY(idHoraSalidaReal) REFERENCES Hora (idHora),
	FOREIGN KEY(idFechaSalida) REFERENCES Fecha (idFecha),
	FOREIGN KEY(idAvion) REFERENCES Avion (idAvion),
	FOREIGN KEY(idFechaLlegada) REFERENCES Fecha (idFecha),
	FOREIGN KEY(idHoraLlegadaReal) REFERENCES Hora (idHora),
	FOREIGN KEY(idAerolinea) REFERENCES Aerolinea (idAerolinea),
	FOREIGN KEY(idAeropuertoDestino) REFERENCES Aeropuerto (idAeropuerto),
	FOREIGN KEY(idAeropuertoOrigen) REFERENCES Aeropuerto (idAeropuerto),
	FOREIGN KEY(idOperadora) REFERENCES Operadora (idOperadora));


