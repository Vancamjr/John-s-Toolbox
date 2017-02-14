
stripPeriods<-function(inString){
  inString = gsub("\\.","", inString)
  return(inString)
}

rmdots("this.is.a.test")

