#Plotting data with ggplot2

#qplot (QUICK PLOT) type is selected with the geom
#geom="point", "smooth", "boxplot", "line", "histogram", "density", "bar", "jitter"
qplot(data$y,geom="histogram")
qplot(data=myData,x=BM,main="Histogram of BodyMass")
m<-qplot(data$y,geom="histogram")

#histograms
data<-acc
m1<-qplot(data$x,geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
m2<-qplot(data$y,geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
m3<-qplot(subset(data$z,data$z<0.01),geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
multiplot(m1, m2, m3, cols=3)
data<-mag
m1<-qplot(data$x,geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
m2<-qplot(data$y,geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
m3<-qplot(data$z,geom="histogram") + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
multiplot(m1, m2, m3, cols=3)

#scatter plots
m1<-ggplot(data=acc, aes(x=t, y=x)) + geom_line() + geom_point() + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
m2<-ggplot(data=acc, aes(x=t, y=y)) + geom_line() + geom_point() + xlab("y-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
m3<-ggplot(data=subset(acc, acc$z<0.01), aes(x=t, y=z)) + geom_line() + geom_point() + xlab("z-axis") + ylab("displacement") + ggtitle("iPhone Accelerometer Data")
multiplot(m1, m2, m3, cols=3)

m1<-ggplot(data=mag, aes(x=t, y=x)) + geom_line() + geom_point() + xlab("x-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
m2<-ggplot(data=mag, aes(x=t, y=y)) + geom_line() + geom_point() + xlab("y-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
m3<-ggplot(data=subset(mag,mag$z<3), aes(x=t, y=z)) + geom_line() + geom_point() + xlab("z-axis") + ylab("displacement") + ggtitle("iPhone Magnetometer Data")
multiplot(m1, m2, m3, cols=3)

#scatter plot
qplot(data=myData,x=BM,y=var1,log="xy",color=Tribe)   #default
qplot(data=myData,x=log(BM),y=log(var1),color=Tribe)  #using logs
#boxplot
qplot(data=myData,x=Hab,y=var1,geom="boxplot")
qplot(data=myData,x=BM,y=var1,log="xy",color=Tribe,facets = Hab~Tribe) #add facets

#Trend lines - adding statistical transformation layers. 
myGG<-qplot(data=myData,x=BM,y=var1,color=Tribe,facets=~Tribe) 
myGG<- myGG + stat_smooth(method="lm")

#Adding Titles
bp + ggtitle("Plant growth") # Equivalent to bp + labs(title="Plant growth")
# If the title is long, it can be split into multiple lines with \n
bp + ggtitle("Plant growth with\ndifferent treatments")
# Reduce line spacing and use bold text
bp + ggtitle("Plant growth with\ndifferent treatments") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))

#saving to a file
ggsave("LIBMFacetsWithTrend.jpg")

library(ggplot2)

# This example uses the ChickWeight dataset, which comes with ggplot2
# First plot
p1 <- 
  ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet, group=Chick)) +
  geom_line() +
  ggtitle("Growth curve for individual chicks")

# Second plot
p2 <- 
  ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("Fitted growth curve per diet")

# Third plot
p3 <- 
  ggplot(subset(ChickWeight, Time==21), aes(x=weight, colour=Diet)) +
  geom_density() +
  ggtitle("Final weight, by diet")

# Fourth plot
p4 <- 
  ggplot(subset(ChickWeight, Time==21), aes(x=weight, fill=Diet)) +
  geom_histogram(colour="black", binwidth=50) +
  facet_grid(Diet ~ .) +
  ggtitle("Final weight, by diet") +
  theme(legend.position="none")        # No legend (redundant in this graph)    

multiplot(p1, p2, p3, p4, cols=2)

