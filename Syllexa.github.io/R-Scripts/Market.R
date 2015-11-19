Market_Graphing<- function(){
  
    
    
  Stock<-dget(file = "https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/GoogFin.R")
  
  Nifty<- Stock(TimeFrame = "1Y")
  Nifty$Change<- ROC(Nifty$Close)
  Nifty$Name<-"Nifty"
  colnames(Nifty)[5]<-"Nifty"
  Sensex<- Stock(ticker = "SENSEX",exchange = "INDEXBOM",TimeFrame = "1Y")
  colnames(Sensex)[5]<- "Sensex"
  
  Data<- cbind(Nifty,Sensex)
  
  Data<- Data[,c("Date","Nifty","Sensex")]
  
  write.csv(Data,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Market-Movement\\data.csv")
  
  }

