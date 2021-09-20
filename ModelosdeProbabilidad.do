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


*Práctica
summarize

*Modelo probabilidad Lineal
 regress coke pratio disp_coke disp_pepsi, vce(robust)
 *Se guardan los estimadores
estimates store lpm
predict phat

*Calcular probabilidad con un punto
margins, predict(xb) at(pratio=1.1 disp_coke=0 disp_pepsi=0)

*Predecir elección comparando con 0.5
generate p1= (phat>=0.5)
tabulate p1 coke, row

*Modelo probit
probit coke pratio disp_coke disp_pepsi
estimates store probit

estat classification

*Promedio marginal
margins, dydx(pratio)

*Efectos marginales
margins, dydx(pratio) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
*predicciones
margins, predict(pr) at(pratio=1.1 disp_coke=0 disp_pepsi=0)

*Pruebas de hipótesis
*Valor prueba1
lincom disp_coke + disp_pepsi
test disp_coke + disp_pepsi =0
test disp_coke disp_pepsi

*Prueba verosimilitud
scalar lnlu=e(ll)
scalar lnlr=e(ll_0)
scalar lr_test=2*(lnlu-lnlr)
di "lnlu =" lnlu
di "lnlr =" lnlr
di "lr_test =" lr_test

gen disp = disp_pepsi-disp_coke
probit coke pratio disp
estimates store probitr

lrtest probit probitr


*Logit
logit coke pratio disp_coke disp_pepsi
estimates store logit
estat classification

margins, dydx(pratio)
margins, dydx(pratio) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
margins, predict(pr) at(pratio=1.1 disp_coke=0 disp_pepsi=0)

