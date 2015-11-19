Time<- proc.time()
Caledar<- dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Economic Calendar.R")
Top_Gainer<- dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Gainer.R")
Top_Loosers<-dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Losers.R")
Currency<-dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Currency.R")
Commodity<-dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Commodities.R")
Market<- dget("https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/R-Scripts/Market.R")

Caledar()
Top_Gainer()
Top_Loosers()
Currency()
Commodity()
Market()

proc.time() -Time