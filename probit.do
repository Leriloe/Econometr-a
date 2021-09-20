*Modelos probit
*Se compara con distribucion Normal (la probabilidad)

*Describir las variables
summarize

probit auto dtime

*se maximisa la funcion maximo verosimilitud en 4 iteraciones con -6.16515
*se obtuvo que auto= -0.0644338 + 0.299898dtime
*es la probabilidad de que se elija auto, no la regresión del tiempo del auto (elección)

*Predecir probabilidades de la muestra
predict phat
*Se evalúa en la derivada, dtime=2

*e calcula con dtime=2
lincom _b[_cons] + _b[dtime]*2
nlcom (normalden(_b[_cons] + _b[dtime]*2))
nlcom (normalden(_b[_cons] + _b[dtime]*2)*_b[dtime])
nlcom (normalden(_b[_cons] + _b[dtime]*3))
