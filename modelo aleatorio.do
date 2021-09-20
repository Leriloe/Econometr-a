drop if LFP == 0
summarize WAGE EDUC EXPER
gen lwage = ln(WAGE)
gen exper2 = EXPER^2
reg lwage EDUC EXPER exper2
estimates store ls 
