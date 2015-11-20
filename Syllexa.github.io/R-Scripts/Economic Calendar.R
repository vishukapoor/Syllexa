News<- function(time_Frame="nextWeek"){
  
  library(XML) 
  
  #Main Website url
  investing_url<-"http://in.investing.com"
  
  #Econoomic calender url
  link<- "http://in.investing.com/economic-calendar/?"
  
  if(time_Frame=="nextWeek"){
    DateFrom<- Sys.Date() +3
    DateTo<- Sys.Date() + 9}
  if(time_Frame=="today"){
    DateFrom<- Sys.Date()
    DateTo<- Sys.Date()}
  if(time_Frame=="tomorrow"){
    DateFrom<- Sys.Date()+1
    DateTo<- Sys.Date()+1}
  if(time_Frame=="yesterday"){
    DateFrom<- Sys.Date()-1
    DateTo<- Sys.Date()-1}
  
  if(time_Frame=="thisWeek"){
    
    DateFrom<- (Sys.Date()-c(6:0))[format((Sys.Date()-c(6:0)),"%w")=="1"]
    DateTo<- Sys.Date()}
  
  
  Paster="&timeZone=23&quotes_search_text=&country%5B%5D=25&country%5B%5D=32&country%5B%5D=6&country%5B%5D=37&country%5B%5D=72&country%5B%5D=22&country%5B%5D=17&country%5B%5D=39&country%5B%5D=14&country%5B%5D=10&country%5B%5D=35&country%5B%5D=43&country%5B%5D=56&country%5B%5D=36&country%5B%5D=110&country%5B%5D=11&country%5B%5D=26&country%5B%5D=12&country%5B%5D=4&country%5B%5D=5&timeFilter=timeRemain&timeFrame="
  
  Paster<- paste("dateFrom","=",DateFrom,"&","dateTo",'=',DateTo,Paster,time_Frame,sep = "")
  
  link<- paste(link,Paster,sep = "")
  
  doc <- readLines(url(link))
  
  #links <- doc[grep("href",doc,ignore.case = T)]
  
  News_Line<-grep("Click to View",doc,ignore.case = T)
  
  day_line<- grep("theDay",doc)
  
  NEWS<-doc[News_Line+1] #Finding all xls files 
  
  day<- doc[day_line]
  
  for(a in seq(day)){
    day[a]<- strsplit(day[a],">")[[1]][2]}
  
  day<- gsub("</td","",day)
  
  NEWS<- as.data.frame(NEWS)
  NEWS$Day<- 0
  
  for(i in seq(day_line)){
    for(a in seq(News_Line)){
      if(day_line[i]<News_Line[a]){
        NEWS$Day[a]<- day[i]}
    }
  }
  
  
  NEWS$NEWS<- as.character(NEWS$NEWS)
  NEWS$Country<- doc[News_Line-2]
  NEWS$News<-0
  NEWS$Actual<- doc[grep("eventactual",doc,ignore.case = T)]
  NEWS$Projection<- doc[grep("eventforecast",doc,ignore.case = T)]
  NEWS$Previous<- doc[grep("eventprevious",doc,ignore.case = T)]
  NEWS$Volatilty<- doc[News_Line-1]
  
  for(a in seq(nrow(NEWS))){
    NEWS$NEWS[a]<-strsplit(strsplit(x = NEWS$NEWS[a],split = "\t\t\t\t")[[1]][2],"</a>")[[1]][1]}
  
  
  NEWS$News<- gsub("(^[[:space:]]+|[[:space:]]+$)", "", NEWS$NEWS)
  
  for(a in seq(nrow(NEWS))){
    NEWS$Country[a]<-strsplit(NEWS$Country[a],split = "class|tittle")[[1]][2]
    NEWS$Projection[a]<-strsplit(NEWS$Projection[a],split = "class|tittle")[[1]][2]
    NEWS$Actual[a]<-strsplit(NEWS$Actual[a],split = "class|tittle")[[1]][2]
    NEWS$Previous[a]<-strsplit(NEWS$Previous[a],split = "class|tittle")[[1]][2]
    NEWS$Volatilty[a]<-strsplit(NEWS$Volatilty[a],split = "class|tittle")[[1]][2]}  
  
  NEWS$Country<- gsub("^=\"","",NEWS$Country)
  
  NEWS$Country<- gsub("\"","",NEWS$Country)
  
  NEWS$Country<- gsub("left flagCur noWrap><span title=","",NEWS$Country)
  
  ###############
  
  
  NEWS$Projection<- gsub("^=\"","",NEWS$Projection)
  
  NEWS$Projection<- gsub("\"","",NEWS$Projection)
  
  for(a in seq(nrow(NEWS))){
    NEWS$Projection[a]<- strsplit(NEWS$Projection[a],">")[[1]][2]}
  
  NEWS$Projection<- gsub("</td","",NEWS$Projection)
  
  NEWS$Projection<- gsub("&nbsp;","No Data",NEWS$Projection)
  
  ######
  
  NEWS$Actual<- gsub("^=\"","",NEWS$Actual)
  
  NEWS$Actual<- gsub("\"","",NEWS$Actual)
  
  for(a in seq(nrow(NEWS))){
    NEWS$Actual[a]<- strsplit(NEWS$Actual[a],">")[[1]][2]}
  
  NEWS$Actual<- gsub("</td","",NEWS$Actual)
  
  NEWS$Actual<- gsub("&nbsp;","No Data",NEWS$Actual)
  
  ################3
  
  NEWS$Previous<- gsub("^=\"","",NEWS$Previous)
  
  NEWS$Previous<- gsub("\"","",NEWS$Previous)
  
  for(a in seq(nrow(NEWS))){
    NEWS$Previous[a]<- strsplit(NEWS$Previous[a],">")[[1]][2]}
  
  NEWS$Previous<- gsub("</td","",NEWS$Previous)
  
  NEWS$Previous<- gsub("&nbsp;","No Data",NEWS$Previous)
  
  ############################3
  
  for(a in seq(nrow(NEWS))){
    NEWS$Volatilty[a]<- strsplit(NEWS$Volatilty[a],"title")[[1]][2]}
  
  NEWS$Volatilty<-gsub("^=\"","",NEWS$Volatilty)
  
  for(a in seq(nrow(NEWS))){
    NEWS$Volatilty[a]<- strsplit(NEWS$Volatilty[a],"\"")[[1]][1]}
  
  NEWS$Link<- doc[News_Line]
  
  for(a in seq(nrow(NEWS))){
    NEWS$Link[a]<- strsplit(NEWS$Link[a],split = "href")[[1]][2]}
  
  NEWS$Link<-gsub("^=\"","",NEWS$Link)
  
  NEWS$Link<- gsub("target=\"_blank\">","",NEWS$Link)
  NEWS$Link<-gsub("\"","",NEWS$Link)
  NEWS$Link<-gsub("(^[[:space:]]+|[[:space:]]+$)", "", NEWS$Link)
  
  NEWS$Link<- paste(investing_url,NEWS$Link,sep = "")
  
  
  NEWS<- NEWS[!duplicated(NEWS),]
  
  
  #for(a in seq(nrow(NEWS))){
  #url<- readLines(url(NEWS$Link[a]))
  
  #NEWS$Detail[a]<- url[grep("overviewBox",url,ignore.case = T)+1]  
  #NEWS$Detail[a]<- strsplit(NEWS$Detail[a],split = "left")[[1]][2]
  #NEWS$Detail[a]<- gsub("\"","",NEWS$Detail[a])
  #NEWS$Detail[a]<- gsub("<BR>","",gsub("/","",NEWS$Detail[a]))
  #NEWS$Detail[a]<- gsub("<div>","",NEWS$Detail[a])
  #NEWS$Detail[a]<- gsub("^>","",NEWS$Detail[a])
  #print(a)}
  
  NEWS$NEWS<-NULL
  NEWS$Link<- NULL
  
  
  name<- paste("C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Economic Calendar","Economic Calender",sep ="//")
  
  name<- paste(name,".csv",sep = "")
  
  write.csv(NEWS,name,row.names = F)

  }