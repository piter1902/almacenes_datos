SELECT a.ESTADO, a.CIUDAD, v.IDAEROPUERTOORIGEN, v.IDAEROLINEA, GROUPING_ID(a.CIUDAD, v.IDAEROPUERTOORIGEN, v.IDAEROLINEA), COUNT(*) AS cuenta
FROM VUELOS v JOIN AEROPUERTO a ON a.IDAEROPUERTO = v.IDAEROPUERTOORIGEN 
WHERE TIEMPODERETRASOSALIDA > 0
GROUP BY a.ESTADO, ROLLUP(a.CIUDAD, v.IDAEROPUERTOORIGEN, v.IDAEROLINEA);
