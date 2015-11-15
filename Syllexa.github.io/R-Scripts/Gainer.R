Gainer<-function(){

setwd("C:\\Users\\Vishu\\OneDrive\\Weekly Digest\\Gainers csv")
library(XML) 
library(rvest)
library(RCurl)
library(httr)
library(DT)
  library(htmltools)
  
investing_url<-"http://profit.ndtv.com/market/stocks-gainers/nifty_weekly"

doc <- readLines(url(investing_url))

links <- grep("txt-right v-align",doc,ignore.case = T)

Stock<- doc[links-1]

for(a in seq(Stock)){
Stock[a]<- strsplit(Stock[a],"\">")[[1]][2]}

Stock<- gsub("</a></td>","",Stock)

Change<- doc[links+5]

for(a in seq(Change)){
  Change[a]<- strsplit(Change[a],"\">")[[1]][3]}

Change<- gsub("</span></td>","",Change)

Weekly_Gainer<- as.data.frame(matrix(0,length(Change),0))

Weekly_Gainer$Stock<- Stock
Weekly_Gainer$Change<- Change

name<-paste("Gainer",Sys.Date(),sep = "-")
name<- paste(name,".csv",sep = "")

Table<-datatable(Weekly_Gainer, class = 'table-bordered table-condensed',options = list(pageLength = 15),caption = "Weekly Top Gainers",selection = "multiple selection")

save_html(Table,"C:\\Users\\Vishu\\OneDrive\\Weekly Digest\\HTML\\Web Files\\Top Gainers.html")

write.csv(Weekly_Gainer,name)

return(Weekly_Gainer)

}
