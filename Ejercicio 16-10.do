*Ejercicio 16.10
*Se usa la base de datos de Olympics

*Se elimina toda la base de datos que no es de los años 1988, 1992 y 1996.
drop if YEAR==60
drop if YEAR==64
drop if YEAR==68
drop if YEAR==72
drop if YEAR==76
drop if YEAR==80
drop if YEAR==84

*La variable SHARE se genera en Excel, y luego se copia a los datos.
summarize share

*a) EL histograma de Share se hace en Excel.
*b) Realizar la siguiente regresión.
gen lnGDP =ln(GDP)
gen lnPop = ln(POP)
regress share lnPop lnGDP HOST SOVIET
*Share = -0.013659 -0.0005388lnPop +0.0012181lnGDP -0.0119647HOST +0.0019787SOVIET
*i) Tan solo la constante y el estimador de lnGDP son estadísticamente relevantes.
*ii) Se grafican los errores estimados contra lnGDP en EXCEL.
predict ehat
*iii) Se calcula la curtosis y el coeficiente de asimetría.
summarize ehat, detail
*c) Las predicciones se hacen en Excel, para mayor facilidad.
*d) Se estima el modelo Tobit.
tobit share lnPop lnGDP HOST SOVIET
*Fue la misma regresión que se estimó en el inciso b).
*Sigma = 0.0000214
