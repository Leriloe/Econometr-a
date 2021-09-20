*Práctica

*1. Se describe la variable
 summarize

*2. Modelo probabilidad Lineal
 regress coke pratio disp_coke disp_pepsi, vce(robust)
 *p = 0.890-0.4008PRatio+0.0771Disp_Coke-0.1656Disp_Pepsi
 *Se guardan los estimadores y estimaciones
 estimates store lpm
 predict phat
 *Calcular probabilidad con un punto específico: pratio=1.1, disp_coke=0, disp_pepsi=0
 margins, predict(xb) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
 *p = 0.4492675

 *Comparación de las predicciones de elección con la elección misma
 *Se genera p1 para separar las elecciones menores a 0.5 con las mayores
 generate p1= (phat>=0.5)
 *Se crea la tabla de frecuencias
 tabulate p1 coke, row
 *De 770 observaciones, el 65.84% no eligieron Coca y su probabilidad es menor a 0.5, 
 *y el 34.16% eligieron Coca a pensar de tener probabilidad menor a 0.5.
 *De las restantes 370 observaciones, el 33.24% no eligieron Coca  apensar de tener una probabilidad mayor a 0.5,
 *y el estante 66.76% sí eligieron Coca teniendo la probabildiad mayor a 0.5

*3. Modelo probit
 probit coke pratio disp_coke disp_pepsi
 *p = Npdf(1.10806 -1.145963PRatio +0.217187Disp_Coke -0.447297Disp_pepsi)
 *Se guardan los estimadores
 estimates store probit
 *Se crea una clasificación con respecto a la predicción
 estat classification
 *66.14% de la tasa general de clasificacón es correcta.
 *510 individuos que eligieron Coca, fueron predecidos 247 correctamente (66.76%).
 *630 individuos que eligieron Pepsi, 507 fueron correctamente predecidos (65.84%).
 *Se calcula el Promedio marginal
 margins, dydx(pratio)
 *AME = -0.4096951
 *Se calculan los efectos marginales: PRatio=1.1, disp_Coke=0, disp_pepsi=0
 margins, dydx(pratio) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
 *dp/dPRatio =-0.4519
 *Se predice la probabilidad en: PRatio=1.1, disp_coke=0, disp_pepsi=0
 margins, predict(pr) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
 *p=0.4393966

*4. Pruebas de hipótesis de Wald, con transformación de Chi-cuadrada, en modelo probit
 *Prueba1: H0:b3=-b4
 *Se suman los estimadores
 lincom disp_coke + disp_pepsi
 *Se hace la prueba
 test disp_coke + disp_pepsi =0
 *W=5.4040>X(1)=3.841, se rechaza H0
 *Prueba 2: H0: b3=b4=0
 test disp_coke disp_pepsi
 *W=19.457>X(2)=5.9915, se acepta H0

*5. Prueba verosimilitud
 *Caso por pasos: se guarda la regresión en escalares y despúes se dicen
 quietly probit coke pratio disp_coke disp_pepsi
 scalar lnlu=e(ll)
 *lnlu=-710.94858
 gen disp = disp_pepsi-disp_coke
 quietly probit coke pratio disp
 scalar lnlr=e(ll)
 *lnlr=-713.65949
 scalar lr_test=2*(lnlu-lnlr)
 *LR=5.4218306
 *Se presentan los datos
 di "lnlu =" lnlu
 di "lnlr =" lnlr
 di "lr_test =" lr_test
 *De forma directa: se usan los dos modelos guardados(con y sin restricciones)
 probit coke pratio disp
 estimates store probitr
 lrtest probit probitr
 *LR=5.42

*6. Modelo Logit
 *Se calcula el modelo y se guardan los estimadores
 logit coke pratio disp_coke disp_pepsi
 *p= L(1.9229-1.9957PRatio+0.3559Disp_coke-0.7309Disp_Pepsi)
 estimates store logit
 *Se crea una clasificación con las predicciones de probabilidad y la elección de  Coca
 estat classification
 *66.14% de la tasa general de clasificacón es correcta.
 *510 individuos que eligieron Coca, fueron predecidos 247 correctamente (66.76%).
 *630 individuos que eligieron Pepsi, 507 fueron correctamente predecidos (65.84%).
 *Se calcula el Promedio marginal
 margins, dydx(pratio)
 *AME=-0.4333
 *Se calculan los efectos marginales: PRatio=1.1, disp_Coke=0, disp_pepsi=0
 margins, dydx(pratio) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
 *dp/dPRatio=-0.489797
 *Se predice la probabilidad en: PRatio=1.1, disp_coke=0, disp_pepsi=0
 margins, predict(pr) at(pratio=1.1 disp_coke=0 disp_pepsi=0)
 *p=0.4323
