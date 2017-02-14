loadxls <-function(myworkbook, myworksheet, desktop=TRUE) {
  ## worksheet must be in xls format (not xlsx or xlsb)
  ## set the directory first or will assume file on desktop
  library(RODBC)
  if (desktop==TRUE) setwd("C:/Documents and Settings/jvancamp/Desktop")
  channel <- odbcConnectExcel(myworkbook)
  mydata <- sqlFetch(channel, myworksheet)
  odbcClose(channel)
  loadxls<-mydata
}