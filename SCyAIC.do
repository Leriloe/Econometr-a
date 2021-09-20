program modelsel
scalar aic = ln(e(rss)/e(N))+2*e(rank)/e(N)
scalar sc = ln(e(rss)/e(N))+e(rank)*ln(e(N))/e(N)
scalar obs = e(N)
scalar list aic sc obs
end


tsset t 
regress gt L(1/2).gt
estat bgodfrey, lags(1 2 3 4 5)
corrgram gt, lags(5)

reg gt L(1/2).gt
scalar ghat1 = _b[_cons]+_b[L1.gt]*gt[98]+ _b[L2.gt]*gt[97]
scalar ghat2 = _b[_cons]+_b[L1.gt]*ghat1+ _b[L2.gt]*gt[98]
scalar ghat3 = _b[_cons]+_b[L1.gt]*ghat2+ _b[L2.gt]*ghat1
scalar list ghat1 ghat2 ghat3
scalar var = e(rmse)^2
scalar se1 = sqrt(var)
scalar se2 = sqrt(var*(1+(_b[L1.gt])^2))
scalar se3 = sqrt(var*((_b[L1.gt]^2+_b[L2.gt])^2+1+_b[L1.gt]^2))
scalar list se1 se2 se3
scalar f1L = ghat1 - invttail(e(df_r), 0.025)*se1
scalar f1U = ghat1 + invttail(e(df_r), 0.025)*se1
scalar f2L = ghat2 - invttail(e(df_r), 0.025)*se2
scalar f2U = ghat2 + invttail(e(df_r), 0.025)*se2
scalar f3L = ghat3 - invttail(e(df_r), 0.025)*se3
scalar f3U = ghat3 + invttail(e(df_r), 0.025)*se3
scalar list f1L f1U f2L f2U f3L f3U
