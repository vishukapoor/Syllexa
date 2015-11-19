Currency<- function(){
    
  

  Function<-dget(file = "https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/GoogFin.R")
  
  USD_INR<- Function(ticker = "USDINR",exchange = "",TimeFrame = "1Y")
  colnames(USD_INR)[5]<- "USD_INR"
  
  Pound_INR<- Function(ticker = "GBPINR",exchange = "",TimeFrame = "1Y")
  colnames(Pound_INR)[5]<-"Pound_INR"
  
  Euro_INR<-Function(ticker = "EURINR",exchange = "",TimeFrame = "1Y")
  colnames(Euro_INR)[5]<-"Euro_INR"
  
  Currency<- cbind(USD_INR,Pound_INR,Euro_INR)
  
  Currency<- Currency[,c("Date","USD_INR","Pound_INR","Euro_INR")]
  
  write.csv(Currency,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Currency\\Currency.csv")
}
