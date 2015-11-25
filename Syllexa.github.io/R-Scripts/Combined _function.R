Time<- proc.time()
Caledar<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Economic Calendar.R")
Top_Gainer<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Weekly Performer.R")
Top_Loosers<-dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Losers.R")
Currency<-dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Currency.R")
Commodity<-dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Commodities.R")
Market<- dget("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Market.R")

Caledar()
Top_Gainer()
Top_Loosers()
Currency()
Commodity()
Market()

proc.time() -Time