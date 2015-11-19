Gainer<-function(){

library(XML) 

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

name<-paste("C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Weekly Gainer","data.csv",sep = "\\")

write.csv(Weekly_Gainer,name)

return(Weekly_Gainer)

}
