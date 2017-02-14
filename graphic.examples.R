x<-rnorm(100)
y<-x + rnorm(100)
g<- gl(2,50,label=c("boy","girl"))
plot(x,y, pch=20, main="scatterplot", xlab="x-axis", ylab="data")
fit<-lm(y ~ x)
abline(fit)
summary(ethanol)
xyplot(y ~ x|s1,
       panel = function(x,y,...){
         panel.xyplot(x,y,...)
         panel.abline(lm(y ~ x))
       }
dotplot(y ~ x|g)
barchart(y ~ x)