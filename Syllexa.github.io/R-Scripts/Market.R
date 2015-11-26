Market_Graphing<- function(){
  
    
    
  Stock<-dget(file = "https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/GoogFin.R")
  
  Nifty<- Stock(TimeFrame = "5Y")
  Nifty$Name<-"Nifty"
  colnames(Nifty)[5]<-"Nifty"
  Sensex<- Stock(ticker = "SENSEX",exchange = "INDEXBOM",TimeFrame = "5Y")
  colnames(Sensex)[5]<- "Sensex"
  
  Nifty<- Nifty[Nifty$Date %in% Sensex$Date,]
  Sensex<- Sensex[Sensex$Date %in% Nifty$Date,]
  
  Data<- cbind(Nifty,Sensex)
  
  Data<- Data[,c("Date","Nifty","Sensex")]
  
  write.csv(Data,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Market-Movement\\data.csv",row.names = F)
  
  }

