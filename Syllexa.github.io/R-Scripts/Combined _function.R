Time<- proc.time()
Caledar<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Economic Calendar.R")
Weekly_Performer<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Weekly Performer.R")
Currency<-dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Currency.R")
Commodity<-dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Commodities.R")
Market<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Market.R")

Caledar()
Weekly_Performer()
Currency()
Commodity()
Market()

proc.time() -Time