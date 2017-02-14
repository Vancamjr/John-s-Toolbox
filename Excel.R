## Read data from an Excel File
## excel("name") where name=a named region in the wb
## prompts for location of the wb 

excel <-function(region="mydata", d=TRUE) {
  ## sets d=directory to the desktop by default
  require(XLConnect)
  if (d==TRUE) setwd("C:/Documents and Settings/jvancamp/Desktop")
  workbook<-file.choose()
  wb = loadWorkbook(workbook, create = TRUE)
  data = readNamedRegion(wb, name = region)
  excel<-data
  rm(wb)
}