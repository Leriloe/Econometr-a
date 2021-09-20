*Modelo Poisson

*Datos objetivos del modelo
keep if YEAR==88
keep MEDALTOT POP GDP

*Generar las variables logarítmicas
gen lpop = ln(POP)
gen lGDP=ln(GDP)

*Se calcula el modelo Poisson y se guardan los resultados
poisson MEDALTOT lpop lGDP
* E(MeldaTot) = -15.88746+0.1800376Lpop+0.5766033LGDP
*				(0.5118048) (0.0322801)	  (0.0247217)
estimates store poisson

*Efectos Marginales en las medianas: lpop=15.73425, lGDP=22.81883
margins, dydx(*) at((median) lpop lGDP)
*dE(Medaltot)/dlpop=0.1995122, dE(Medaltot)/dlGDP=0.6389744
*				(0.0389282)		(0.0402253)
*Predicción del valor esperado codicional en las medianas: lpop=15.73425, lGDP=22.8188
margins, predict(n) at((median) lpop lGDP)
*E(MedalTot)=1.10817
*		(0.0903926)
