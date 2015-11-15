Market_Graphing<- function(){
  
  library(dygraphs)
  library(xts)
  library(TTR)
  library(htmltools)
    
    
  Stock<-dget(file = "C:\\Users\\Vishu\\OneDrive\\Data Scraping\\NSE-BSE Historical Prices\\GoogFin.R")
  
  Nifty<- Stock(TimeFrame = "1Y")
  Nifty$Change<- ROC(Nifty$Close)
  Nifty$Name<-"Nifty"
  colnames(Nifty)[5]<-"Nifty"
  Sensex<- Stock(ticker = "SENSEX",exchange = "INDEXBOM",TimeFrame = "1Y")
  Sensex$Return<- ROC(Sensex$Close)
  colnames(Sensex)[5]<- "Sensex"
  
  Data<- cbind(Nifty,Sensex)
  
  Data<- Data[,c("Date","Nifty","Sensex")]
  
  
  }

