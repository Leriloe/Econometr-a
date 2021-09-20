*Limpiamos la base
drop if lfp == 0

*Generamos la primera regresión para la prueba de Haussman
*Para esto planteamos el modelo tomando en consideración las variables
*EXPER, EXPER2, MOTHEREDUC Y FATHEREDUC
	gen EXPER2 = exper^2
	reg educ exper EXPER2 mothereduc fathereduc
	
*Después de generar esta regresión, encontramos los residuales de 
*MCO los cuales se obtienen restando las estimaciones y la variable original 
	gen EDUCEST = 9.1026 + 0.0452*exper - 0.0010*EXPER2 + 0.1576*mothereduc + 0.1895*fathereduc
	gen VEST = educ - EDUCEST

*Corremos la regresión de WAGE
	gen LWAGE = ln(wage)
	reg LWAGE educ exper EXPER2 VEST
		*Realizamos la prueba t con los estadísticos de la regresión
	
*Calcular los errores robustos de la regresión	
	reg LWAGE educ exper EXPER2 VEST, robust
	
		
*Verificamos significancia de variables instrumentales
	gen LWAGEST = 0.0481 + 0.0614*educ + 0.0442*exper - 0.0009*EXPER2 + 0.0582*VEST
	gen ehat = LWAGE - LWAGEST
	reg ehat mothereduc fathereduc
		*Se generó la regresión sobre las variables instrumentales 
		*Se obtiene que N = 428 y R2 Ajustada = 0.0009
		*Luego N*R2 Ajustada = 0.39 .......... (%)

*Prueba de Hausman directa
	ivregress 2sls LWAGE (educ = mothereduc) exper EXPER2, small
		estimates store iv
	reg LWAGE educ exper EXPER2 VEST
		estimates store lm
	hausman iv lm, constant sigmamore
		*Se obtiene que Chi2 = 0.39
		*Recordar que N*R2 Ajustada ~ Chi2
		*Este Chi2 = N*R2 Ajustada obtenido en (%)
		
	
	