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

name<-paste("CNX Top Loser's",Sys.Date(),sep = "-")
name<- paste(name,".csv",sep = "")

datatable(Losers, class = 'table-bordered table-condensed',options = list(pageLength = 15),caption = "Weekly Top Loosers",selection = "multiple selection")

