SELECT origen.NOMBREAEROLINEA, origen.ESTADO, origen.CIUDAD, origen.NOMBREAEROPUERTO, COUNT(*)
FROM (SELECT * FROM (VUELOS v  JOIN AEROPUERTO a ON a.IDAEROPUERTO = v.IDAEROPUERTOORIGEN) 
							   JOIN AEROLINEA a2 ON a2.IDAEROLINEA = v.IDAEROLINEA) origen
GROUP BY origen.NOMBREAEROLINEA, origen.ESTADO, ROLLUP(origen.CIUDAD, origen.NOMBREAEROPUERTO);