## creates a histogram with a normal distribution fit
##########################################################################################

hist_counts <- function(x, breaks, ...){
mypanel <- function(x, breaks, nint = round(log2(length(x)) + 1), ...)
{
  if (missing(breaks))
    breaks <- do.breaks(range(x, finite = TRUE), nint)
    panel.histogram(x, breaks = breaks, ...)
    h <- hist(x, breaks = breaks, plot = FALSE)
    breaks <- h$breaks
    nb <- length(breaks)
    yy <- h$counts
    #    yy <- 100 * h$counts / length(x)
    panel.text(x = (breaks[-1] + breaks[-nb])/2, y = yy,
             labels = round(cumsum(yy), 2), pos = 3)
    #panel.text(150,50,lab="Delay",just="left")
}
# This is the histogram code:
histogram(x,nint=20, panel=mypanel,type="count", ...)
}
