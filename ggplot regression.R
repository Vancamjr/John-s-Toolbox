
ggplotRegression <- function (fit) {  
  require(ggplot2)
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    ggtitle(paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
        "; Intercept =",signif(fit$coef[[1]],5 ),
        "; Slope =",signif(fit$coef[[2]], 5),
        "; P =",signif(summary(fit)$coef[2,4], 5)))
}

#After specifying this function, all you would have to run is:
#   
# fit1 <- lm(Sepal.Length ~ Petal.Width, data = iris)
# ggplotRegression(fit1)
# 
# or even just
# 
# ggplotRegression(lm(Sepal.Length ~ Petal.Width, data = iris))

#Using LM to fit other values
# after running the model [fit<-lm(y~x)] the fit is used as follows 
lmpredict<- function(fit,value){
  b<-coef(fit)[1]
  m<-coef(fit)[2]
  return(value*m+b)
}
#here we predict the outcome over a sequence of values 
lmpredict(fit,seq(44,57))

#here we plot the preducted series
plot(seq(44,57),mypredict(fit,seq(44,57)))

