Loser<- function(){

library(XML) 
library(DT)
library(htmltools)  
  
setwd("C:\\Users\\Vishu\\OneDrive\\Weekly Digest\\Loosers csv")
  
investing_url<-"http://profit.ndtv.com/market/stocks-losers/nifty_daily"

Losers<-readHTMLTable(investing_url)

Losers<- as.data.frame(Losers)

Losers<- Losers[,colnames(Losers)%in% c("common.table.Company","common.table.Change..")]

Losers<- Losers[-1,]

colnames(Losers)<- gsub("common.table.","",colnames(Losers)) 

write.csv(Losers,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Weekly Looser\\data.csv",row.names = F)

}