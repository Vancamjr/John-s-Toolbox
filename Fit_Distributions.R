#Read Data into X, take a column X1 and try fitting distributions

x1 <- x[,2]

fitn <- fitdist(x1, "norm")
plot(fitn)
summary(fitn)
fitw <- fitdist(x1, "weibull")
plot(fitw)
summary(fitw)
fitg <- fitdist(x1, "gamma")
plot(fitg)
summary(fitg)
fitln <- fitdist(x1, "lnorm")
plot(fitln)
summary(fitln)
cdfcomp(list(fitn, fitw, fitg, fitln), legendtext=c("norm", "Weibull", "gamma", "lognormal"))
denscomp(list(fitn, fitw, fitg, fitln), legendtext=c("norm", "Weibull", "gamma", "lognormal"))
qqcomp(list(fitn, fitw, fitg, fitln), legendtext=c("norm", "Weibull", "gamma", "lognormal"))
ppcomp(list(fitn, fitw, fitg, fitln), legendtext=c("norm", "Weibull", "gamma", "lognormal"))

#fit binomial distribution
fitx <- fitdist(x1, "exp")
plot(fitx)
summary(fitx)
