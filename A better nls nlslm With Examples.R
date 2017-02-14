## A Better nls

# Those that do a lot of nonlinear regression will love the nls function of R. In most of the 
# cases it works really well, but there are some mishaps that can occur when using bad starting 
# values for the parameters. One of the most dreaded is the "singular gradient matrix at initial
# parameter estimates" which brings the function to a stop because the gradient check in 
# stats:::nlsModel will terminate if the QR decomposition is not of full column rank.
# 
# Nearly all nonlinear fitting programs out there use the Levenberg-Marquardt algorithm for 
# nonlinear regression. This is because its switching between Gauss-Newton and gradient descent 
# is highly robust against far-off-optimal starting values.  Unfortunately, the standard nls 
# function has no LM implemented, instead it houses the Gauss-Newton type, the PORT routines 
# and a partial linear fitter. The fabulous minpack.lm package from Katherine M. Mullen offers 
# an R frontend to a Fortran LM implementation of the MINPACK package. The nls.lm function must 
# be supplied with an objective function that returns a vector of residuals to be minimized. 
# Together with Kate I developed a function nlsLM that has the gee wizz formulaic interface of 
# nls, but it calls LM instead of Gauss-Newton. This has some advantages as we will see below.  
# The function returns the usual result of class 'nls', and due to some modifications, all 
# standard generics work. The modifications were made so that the formula is transformed into a 
# function that returns a vector of (weighted) residuals whose sum square is minimized by nls.lm. 
# The optimized parameters are then transferred to stats:::nlsModel in order to obtain an object 
# of class 'nlsModel'. The internal C  functions C_nls_iter and stats:::nls_port_fit were removed 
# to avoid subsequent "Gauss-Newton", "port" or "plinear" optimization of nlsModel.
# 
# So, what's similar and what's, well, better.

library(minpack.lm)
### Examples from 'nls' doc ###
DNase1 <- subset(DNase, Run == 1)
fm1DNase1 <- nlsLM(density ~ Asym/(1 + exp((xmid - log(conc))/scal)),
                   data = DNase1, start = list(Asym = 3, xmid = 0, scal = 1))
## all generics are applicable
coef(fm1DNase1)
confint(fm1DNase1)
deviance(fm1DNase1)
df.residual(fm1DNase1)
fitted(fm1DNase1)
formula(fm1DNase1)
logLik(fm1DNase1)
predict(fm1DNase1)
print(fm1DNase1)
profile(fm1DNase1)
residuals(fm1DNase1)
summary(fm1DNase1)
update(fm1DNase1)
vcov(fm1DNase1)
weights(fm1DNase1)

# nlsLM can fit zero noise data, when nls fails:
x <- 1:10
y <- 2*x + 3                          
nls(y ~ a + b * x, start = list(a = 0.12345, b = 0.54321))
nlsLM(y ~ a + b * x, start = list(a = 0.12345, b = 0.54321))

# nlsLM often converges when nls gives the dreaded "singular gradient" error.
# Example taken from here:
x <- 0:140
y <- 200 / (1 + exp(17 - x)/2) * exp(-0.02*x)
yeps <- y + rnorm(length(y), sd = 2)
nls(yeps ~ p1 / (1 + exp(p2 - x)) * exp(p4 * x), start=list(p1=410,p2=18,p4=-.03))
# Nonlinear regression model
# model: yeps ~ p1/(1 + exp(p2 - x)) * exp(p4 * x)
# data: parent.frame()
# p1        p2        p4 
# 199.59950  16.31312  -0.01992 
# residual sum-of-squares: 409.3
# 
# Number of iterations to convergence: 5 
# Achieved convergence tolerance: 1.953e-06

nlsLM(yeps ~ p1 / (1 + exp(p2 - x)) * exp(p4 * x), start=list(p1=10,p2=18,p4=-.03))
# Nonlinear regression model
# model: yeps ~ p1/(1 + exp(p2 - x)) * exp(p4 * x)
# data: parent.frame()
# p1        p2        p4 
# 199.59951  16.31312  -0.01992 
# residual sum-of-squares: 409.3
# 
# Number of iterations to convergence: 10 
# Achieved convergence tolerance: 1.49e-08
