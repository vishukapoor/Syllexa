Weekly_Performance<- function(){

library(TTR)

Function<-dget(file = "https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/GoogFin.R")

List<- read.csv("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/ind_niftylist.csv")

List$Company.Name<- as.character(List$Company.Name)

List$Symbol<- as.character(List$Symbol)

Weekly_Gainer<- as.data.frame(matrix(0,nrow(List),0))
Weekly_Loser<- as.data.frame(matrix(0,nrow(List),0))

Weekly_Gainer$Name<- 0
Weekly_Gainer$Return<- 0

Weekly_Loser$Name<- 0
Weekly_Loser$Return<- 0

DateFrom<- (Sys.Date()-c(6:0))[format((Sys.Date()-c(6:0)),"%w")=="1"]


for(a in seq(List$Symbol)){

  Data<-try(Function(ticker = List$Symbol[a],TimeFrame = "1M"))
  if(inherits(Data,"try-error")){next(a)}
  
  
  Data<- Data[Data$Date>= DateFrom,]
  
  
  if(Data$Close[nrow(Data)]-Data$Close[1]>0)
  {Weekly_Gainer$Name[a]<- List$Company.Name[a] }
  if(Data$Close[nrow(Data)]-Data$Close[1]>0)
  {Weekly_Gainer$Return[a]<-  ((Data$Close[nrow(Data)]-Data$Close[1])/Data$Close[1])*100}
  
    
  if(Data$Close[nrow(Data)]-Data$Close[1]<0)
  {Weekly_Loser$Name[a]<- List$Company.Name[a] }
  if(Data$Close[nrow(Data)]-Data$Close[1]<0)
  {Weekly_Loser$Return[a]<-  ((Data$Close[nrow(Data)]-Data$Close[1])/Data$Close[1])*100}
}  
  
  Weekly_Gainer<- subset(Weekly_Gainer,Weekly_Gainer$Name!=0)
  Weekly_Loser<- subset(Weekly_Loser,Weekly_Loser$Name!=0)
  Weekly_Gainer$Return<- round(Weekly_Gainer$Return,2)
  Weekly_Loser$Return<- round(Weekly_Loser$Return,2)
  
  name<-paste("C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Weekly Gainer","data.csv",sep = "\\")
  
  write.csv(Weekly_Gainer,name,row.names = F)
  write.csv(Weekly_Loser,"C:\\Users\\Vishu\\Documents\\GitHub\\Syllexa\\Syllexa.github.io\\Weekly Looser\\data.csv",row.names = F)
  
}
