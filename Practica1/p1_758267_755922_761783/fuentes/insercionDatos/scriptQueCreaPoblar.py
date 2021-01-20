import string
import random


DiccAvion = {}
# Nombre, código modelo, matrícula
for i in range(30):
	DiccAvion[i*10 + 0] = {(i*10 + 0, 'Boeing 787-9', '789', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 1] = {(i*10 + 1, 'Boeing 787-8', '78P', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 2] = {(i*10 + 2, 'Boeing 777-300', '773', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 3] = {(i*10 + 3, 'Boeing 777-200', '772', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 4] = {(i*10 + 4, 'Boeing 767-300', '76P', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 5] = {(i*10 + 5, 'Boeing 737-800', '73L', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 6] = {(i*10 + 6, 'Airbus A321', '321', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 7] = {(i*10 + 7, 'Airbus A320', '32G', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 8] = {(i*10 + 8, 'Bombardier DHC8-Q400', 'Q4A', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}
	DiccAvion[i*10 + 9] = {(i*10 + 9, 'Bombardier DHC8-Q200', 'Q82', 'EC-A' + str(random.randint(1,9999)) + str(random.randint(1,9999)))}

for i in range(300):
	print("INSERT INTO Avion VALUES " + ','.join(str(j) for j in DiccAvion[i]) + ";")

DiccAeropuerto = {}
# Nombre aeropuerto, código aeropuerto, ciudad, estado
DiccAeropuerto[0] = {(0,'Aeropuerto Internacional Hartsfield-Jackson', 'ATL', 'Atlanta', 'GA')}
DiccAeropuerto[1] = {(1,'Aeropuerto Internacional de Los Ángeles', 'LAX', 'Los Angeles', 'CA')}
DiccAeropuerto[2] = {(2,'Aeropuerto Internacional OHare', 'ORD', 'Chicago', 'IL')}
DiccAeropuerto[3] = {(3,'Aeropuerto Internacional de Dallas-Fort Worth', 'DFW', 'Dallas', 'TX')}
DiccAeropuerto[4] = {(4,'Aeropuerto Internacional de Denver', 'DEN', 'Denver', 'CO')}
DiccAeropuerto[5] = {(5,'Aeropuerto Internacional John F. Kennedy', 'JFK',  'Nueva York', 'NY')}
DiccAeropuerto[6] = {(6,'Aeropuerto Internacional de San Francisco', 'SFO', 'San Francisco', 'CA')}
DiccAeropuerto[7] = {(7,'Aeropuerto Internacional de Seattle-Tacoma', 'SEA', 'Seattle', 'WA')}
DiccAeropuerto[8] = {(8,'Aeropuerto Internacional McCarran', 'LAS', 'Las Vegas', 'NV')}
DiccAeropuerto[9] = {(9,'Aeropuerto Internacional de Orlando', 'MCO', 'Orlando', 'FL')}
DiccAeropuerto[10] = {(10,'Aeropuerto Internacional Libertad de Newark', 'EWR', 'Newark', 'NJ')}
DiccAeropuerto[11] = {(11,'Aeropuerto Internacional de Charlotte-Douglas', 'CLT', 'Charlotte', 'NC')}
DiccAeropuerto[12] = {(12,'Aeropuerto Internacional de Phoenix-Sky Harbor', 'PHX', 'Phoenix', 'AZ')}
DiccAeropuerto[13] = {(13,'Aeropuerto Intercontinental George Bush', 'IAH', 'Houston', 'TX')}
DiccAeropuerto[14] = {(14,'Aeropuerto Internacional de Miami', 'MIA', 'Miami', 'FL')}
DiccAeropuerto[15] = {(15,'Aeropuerto Internacional Logan', 'BOS', 'Boston', 'MA')}
DiccAeropuerto[16] = {(16,'Aeropuerto Internacional de Mineápolis-Saint Paul', 'MSP', 'Mineápolis', 'MN')}
DiccAeropuerto[17] = {(17,'Aeropuerto Internacional de Fort Lauderdale-Hollywood', 'FLL', 'Fort Lauderdale', 'FL')}
DiccAeropuerto[18] = {(18,'Aeropuerto Internacional de Detroit', 'DTW', 'Detroit', 'MI')}
DiccAeropuerto[19] = {(19,'Aeropuerto Internacional de Filadelfia', 'PHL', 'Filadelfia', 'PA')}
DiccAeropuerto[20] = {(20,'Aeropuerto LaGuardia', 'LGA', 'Nueva York', 'NY')}
DiccAeropuerto[21] = {(21,'Aeropuerto Internacional de Baltimore-Washington', 'BWI', 'Baltimore', 'MD')}
DiccAeropuerto[22] = {(22,'Aeropuerto Internacional de Salt Lake City', 'SLC', 'Salt Lake City', 'UT')}
DiccAeropuerto[23] = {(23,'Aeropuerto Internacional de San Diego', 'SAN', 'San Diego', 'CA')}
DiccAeropuerto[24] = {(24,'Aeropuerto Internacional de Washington-Dulles', 'IAD', 'Washington D.C.', 'VA')}
DiccAeropuerto[25] = {(25,'Aeropuerto Nacional Ronald Reagan de Washington', 'DCA', 'Washington D.C.', 'VA')}
DiccAeropuerto[26] = {(26,'Aeropuerto Internacional Midway', 'MDW', 'Chicago', 'IL')}
DiccAeropuerto[27] = {(27,'Aeropuerto Internacional de Tampa', 'TPA', 'Tampa', 'FL')}
DiccAeropuerto[28] = {(28,'Aeropuerto Internacional de Portland', 'PDX', 'Portland', 'OR')}
DiccAeropuerto[29] = {(29,'Aeropuerto Internacional Daniel K. Inouye', 'HNL', 'Honolulu', 'HI')}

for i in range(30):
	print("INSERT INTO Aeropuerto VALUES " + ','.join(str(j) for j in DiccAeropuerto[i]) + ";")

DiccAerolinea = {}
# Nombre aerolinea, código aerolinea
DiccAerolinea[0] = {(0, 'Allegiant Air', 'G4')}
DiccAerolinea[1] = {(1, 'United Airlines', 'UA')}
DiccAerolinea[2] = {(2,'Delta Air Lines', 'DL')}
DiccAerolinea[3] = {(3, 'American Airlines', 'AA')}
DiccAerolinea[4] = {(4, 'Spirit Airlines', 'NK')}
DiccAerolinea[5] = {(5, 'PAKLOOK AIR INC.', 'K2')}
DiccAerolinea[6] = {(6, 'JetBlue Airways', 'B6')}
DiccAerolinea[7] = {(7, 'Frontier Airlines', 'F9')}
DiccAerolinea[8] = {(8, 'Alaska Airlines', 'AS')}
DiccAerolinea[9] = {(9, 'Southwest Airlines', 'WN')}

DiccOperadora = {}
# Nombre operadora, código operadora
DiccOperadora[0] = {(0, 'Allegiant Air', 'G4')}
DiccOperadora[1] = {(1, 'United Airlines', 'UA')}
DiccOperadora[2] = {(2,'Delta Air Lines', 'DL')}
DiccOperadora[3] = {(3, 'American Airlines', 'AA')}
DiccOperadora[4] = {(4, 'Spirit Airlines', 'NK')}
DiccOperadora[5] = {(5, 'PAKLOOK AIR INC.', 'K2')}
DiccOperadora[6] = {(6, 'JetBlue Airways', 'B6')}
DiccOperadora[7] = {(7, 'Frontier Airlines', 'F9')}
DiccOperadora[8] = {(8, 'Alaska Airlines', 'AS')}
DiccOperadora[9] = {(9, 'Southwest Airlines', 'WN')}

for i in range(10):
	print("INSERT INTO Aerolinea VALUES " + ','.join(str(j) for j in DiccAerolinea[i]) + ";")
	print("INSERT INTO Operadora VALUES " + ','.join(str(j) for j in DiccOperadora[i]) + ";")

DiccHora = {}
# horaMinutos24Horas(hh:mm), horaMinutosAM/PM(hh:mm), indicarAM/PM, indicadorFranjaHorario
for i in range(7000):
	hora = random.randint(12,23)
	minuto = random.randint(0,59)
	DiccHora[i] = (i, str("{0:0=2d}".format(hora) + ":" + "{0:0=2d}".format(minuto)), str("{0:0=2d}".format(hora-12) + ":" + "{0:0=2d}".format(minuto)), 'PM', 'CEST')
	hora = [j for j in DiccHora[i]]
	for j in range(1, len(hora)):
		hora[j] = "'" + hora[j] + "'"
	print("INSERT INTO Hora VALUES (" + ','.join(str(j) for j in hora) + ");")

# Se utiliza únicamente una fecha para concentrar los vuelos
DiccFecha = {}
Meses = ["nada", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
diasMeses = ["nada", 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Semana = ["nada", "lunes", "martes", "miercoles", "jueves", "viernes", "sabado", "domingo"]
diasMes = 31
for i in range(7000):

	mesNumero = random.randint(1,12)
	mes = Meses[mesNumero]
	año = random.randint(2005, 2019)
	diaEnMes = random.randint(1, diasMeses[mesNumero])
	diaSemanaNumero = random.randint(1,7)
	diaSemana = Semana[diaSemanaNumero]
	diaEnAño = (int)(diasMes*(mesNumero-1)) + diaEnMes

	esFinde = "'NO'"
	if(diaSemanaNumero == 6 or diaSemanaNumero == 7):
		esFinde = "'SI'"

	cuatrimestre = "Q4"
	if(mesNumero <= 3):
		cuatrimestre = "Q1"
	elif(mesNumero <= 6):
		cuatrimestre = "Q2"
	elif(mesNumero <= 9):
		cuatrimestre = "Q3"

	DiccFecha[i] = (i, "'" + str(diaEnMes) + " de " + mes + " de " + str(año) + "'", "'" + diaSemana + "'", diaEnAño, diaEnMes, "'" + mes + "'", mesNumero, "'" + mes + " de " + str(año) + "'", "'" + cuatrimestre + "'", "'" + cuatrimestre + " de " + str(año) + "'", diaEnAño, "'NO'", esFinde, "'NO'", "'NO'", str(año))

	print("INSERT INTO Fecha VALUES (" + ','.join(str(j) for j in DiccFecha[i]) + ");")

# Devuelve cierto si y solo si pri es anterior a sec
def horaAnterior(pri, sec):
	priHora = pri[1].split(":")
	secHora = sec[1].split(":")
	if(int(priHora[0]) < int(secHora[0])):
		return True
	elif(int(priHora[0]) == int(secHora[0]) and int(priHora[1]) < int(secHora[1])):
		return True
	return False


for i in range(900):

	# Todos los vuelos son el día 1 entre las 00 y las 12 pm, la resta es directa
	horaInit = random.randint(1,7000) - 1
	horaFin = random.randint(1,7000) - 1
	while(not horaAnterior(DiccHora[horaInit], DiccHora[horaFin])):
		horaInit = random.randint(1,7000) - 1
		horaFin = random.randint(1,7000) - 1
	
	horaInicialDefinitiva = DiccHora[horaInit]
	horaFinalDefinitiva = DiccHora[horaFin]
	minsHoraInitReal = horaInicialDefinitiva[1].split(":")
	minsHoraInitReal = int(minsHoraInitReal[0])*60 + int(minsHoraInitReal[1])
	minsHoraFinReal = horaFinalDefinitiva[1].split(":")
	minsHoraFinReal = int(minsHoraFinReal[0])*60 + int(minsHoraFinReal[1])
	tiempoRealVuelo = minsHoraFinReal - minsHoraInitReal
	
	retrasoSalida = 0
	retrasoLlegada = 0
	minsHoraInitEstimada = minsHoraInitReal
	minsHoraFinEstimada = minsHoraFinReal

	if(random.randint(1,9) % 9 == 0):
		retrasoLlegada = random.randint(0,30)
		minsHoraFinEstimada = minsHoraFinReal - retrasoLlegada
		if(minsHoraFinEstimada - minsHoraInitEstimada <= 0):
			minsHoraFinEstimada = minsHoraFinReal
			retrasoLlegada = 0

	if(random.randint(1,9) % 9 == 0):
		retrasoSalida = random.randint(0,30)
		minsHoraInitEstimada = minsHoraInitReal - retrasoSalida
		if(minsHoraInitEstimada - minsHoraInitReal <= 0):
			minsHoraInitEstimada = minsHoraInitReal
			retrasoSalida = 0

	tiempoEstimadoVuelo = minsHoraFinEstimada - minsHoraInitEstimada
	tiempoTotalDelVuelo = minsHoraFinReal - minsHoraInitEstimada
	tiempoAdelantadoLlegada = max([minsHoraFinEstimada - minsHoraFinReal, 0])

	"""print(horaInicialDefinitiva)
	print(horaFinalDefinitiva)
	print("Minutos hora inicial real: " + str(minsHoraInitReal))
	print("Minutos hora inicial estimada: " + str(minsHoraInitEstimada))
	print("Minutos hora final real: " + str(minsHoraFinReal))
	print("Minutos hora final estimada: " + str(minsHoraFinEstimada))
	print("Minutos retraso salida: " + str(retrasoSalida))
	print("Minutos retraso llegada: " + str(retrasoLlegada))
	print("Minutos total vuelo: " + str(tiempoTotalDelVuelo))
	print("Minutos estimado vuelo: " + str(tiempoEstimadoVuelo))
	print("Minutos adelantado llegada: " + str(tiempoAdelantadoLlegada))
	print("Minutos real vuelo: " + str(tiempoRealVuelo))"""


	print("INSERT INTO Vuelos VALUES (" + str(horaInit) + ",0," + str(random.randint(0,299)) + ",0," +  str(horaFin) + "," + str(random.randint(0,9)) + "," + str(random.randint(0,29)) + "," + str(random.randint(0,29))  + "," + str(random.randint(0,9)) + "," + "'" + str(random.randint(100000, 999999)) + "'" + "," + str(tiempoRealVuelo) + "," + str(tiempoEstimadoVuelo) + "," + str(retrasoLlegada) + "," + str(tiempoTotalDelVuelo) + "," + str(retrasoSalida) + "," + str(tiempoAdelantadoLlegada) + ");")
	
