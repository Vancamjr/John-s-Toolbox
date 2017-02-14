## creates a histogram with a normal distribution fit
##########################################################################################

library("lattice", lib.loc="C:/Program Files/R/R-3.0.1/library")

hist_fit <- function(x, breaks, ...){
mypanel <- function(x, breaks, nint = round(log2(length(x)) + 1), ...)
{
  if (missing(breaks))
    breaks <- do.breaks(range(x, finite = TRUE), nint)
    panel.histogram(x, breaks = breaks, ...)
    h <- hist(x, breaks = breaks, plot = FALSE)
    xfit<-seq(min(x),max(x),length=40)
    yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
    yfit <- yfit*diff(h$mids[1:2])*length(x)
    panel.lines(xfit, yfit, col="blue", lwd=2)
}
# This is the histogram code:
xlab<-paste("Mean= ",format(mean(x),2),"   SDEV= ",format(sd(x),2),sep='')
histogram(x,nint=10, xlab=xlab, panel=mypanel,type="count", ...)
}