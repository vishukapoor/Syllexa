Commodity<- function(){

  
  library(XML) #Loading XML package
  library(gdata)

  setwd("C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Commodity")
    
  url<-"http://www.goldpriceindia.com/gold-price-history.php"

  url1<-"http://www.goldpriceindia.com/" 

  doc <- htmlParse(url) #Parses an HTML file and form a readable R file

  links <- xpathSApply(doc, "//a/@href")

  Links<-links[grep("2015",links,ignore.case = T)] 

  Links<- Links[c(-1,-2)]

  Month_URL<- paste(url1,Links,sep = "")


  Gold_Date<- list()
  Gold_Data<- list()
  
  for(a in seq(Month_URL)){
    url<- Month_URL[a]
    doc <- readLines(url)
    Month_Data<-list()
    Month_Date<- list()
    
    for(i in seq(length(grep("his-dt-G-hd",doc)))){
    Month_Date[i]<-strsplit(doc[grep("his-dt-G-hd",doc)],"his-dt-G-hd")[[i]][2]
    Month_Date[i]<-gsub("\" colspan=\"4\">|</td>","",Month_Date[i])}
    
    for(i in seq(length(grep("his-eod-2",doc)))){
    Month_Data[i]<- strsplit(doc[grep("his-eod-2",doc)],"his-eod-2")[[i]][2]
    Month_Data[i]<- gsub("\\\">|</td>","",Month_Data[i])}
    
    
    if(a==1){Gold_Date=Month_Date}
    else(Gold_Date<- c(Gold_Date,Month_Date))
    
    if(a==1){Gold_Data=Month_Data}
    else(Gold_Data<- c(Gold_Data,Month_Data))
    

  }  
  
  Gold_Data<- unlist(Gold_Data)
  Gold_Date<- unlist(Gold_Date)
  
  Gold_Date<- as.Date(gsub("Gold Price on ","",Gold_Date),"%d %B %Y")
  Gold_Data<- as.numeric(gsub(",","",Gold_Data))
  
  Gold<- as.data.frame(x = Gold_Date)  
  colnames(Gold)<- "Date"
  Gold$Data<- Gold_Data
  
  Oil<- read.xls("http://www.eia.gov/dnav/pet/xls/PET_PRI_FUT_S1_D.xls",sheet = 2,pattern = "Date")
  Oil$Date<- as.Date(as.character(Oil$Date),format = "%b %d, %Y")
  colnames(Oil)[2]<- "Prices"
  
  Oil<- subset(Oil,Oil$Prices!=".")
  
  Oil<- Oil[format(Oil$Date,"%Y")==format(Sys.Date(),"%Y"),]
  
  Oil<-Oil[,c(1,2)] 
  
  Gold<- Gold[order(Gold$Date),]
  
  Gold<- Gold[Gold$Date %in% Oil$Date,]
  
  Commodity<- cbind(Gold,Oil)
  
  Commodity<- Commodity[,!(duplicated(colnames(Commodity)))]
  
  colnames(Commodity) <- c("Date","Gold","Oil")
  
  Commodity$Gold<- round(Commodity$Gold)
  Commodity$Oil<- round(Commodity$Oil)
  
  write.csv(Commodity,"data.csv",row.names = F)  
  
  }
