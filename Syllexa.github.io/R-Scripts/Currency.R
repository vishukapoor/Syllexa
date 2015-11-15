Currency<- function(){

library(rjson)
  
Function<-dget(file = "C:\\Users\\Vishu\\OneDrive\\Data Scraping\\NSE-BSE Historical Prices\\GoogFin.R")

USD_INR<- Function(ticker = "USDINR",exchange = "",TimeFrame = "1Y")
colnames(USD_INR)[5]<- "USD_INR"

Pound_INR<- Function(ticker = "GBPINR",exchange = "",TimeFrame = "1Y")
colnames(Pound_INR)[5]<-"Pound_INR"

Euro_INR<-Function(ticker = "EURINR",exchange = "",TimeFrame = "1Y")
colnames(Euro_INR)[5]<-"Euro_INR"

Currency<- cbind(USD_INR,Pound_INR,Euro_INR)

Currency<- Currency[,c("Date","USD_INR","Pound_INR","Euro_INR")]

Currency_JSON<-toJSON(Currency)

write(Currency_JSON,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Chart\\Currency\\Currency.json")
}
