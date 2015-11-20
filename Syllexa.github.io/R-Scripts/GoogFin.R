download_prices <- function(ticker = ".NSEI", exchange = "NSE", interval = 86400, TimeFrame = "10Y"){

      url = paste("http://www.google.com/finance/getprices?q", paste(ticker, "x", sep = "&"), paste(exchange, "i", sep = "&"), paste(interval, "p", sep = "&"), 
                  paste(TimeFrame, "f", sep = "&"), "d,o,h,l,c,v", sep = "=")
      #print(url)
      
      stock = readLines(url)
      
      colnames_row = strsplit(stock[5], split = ",")
      
      columns = c(gsub(x = colnames_row[[1]][1], pattern = "COLUMNS=", replacement = ""), colnames_row[[1]][2], colnames_row[[1]][3],
                  colnames_row[[1]][4], colnames_row[[1]][5], colnames_row[[1]][6])
      
      stock_prices = data.frame(matrix(data = 0, nrow = 0, ncol = length(columns)))
      
      colnames(x = stock_prices) = columns
      
      rows = length(stock)
      
      
      for(i in 8:rows){
        
        elements = strsplit(x = stock[i], split = ",")
        stock_prices[i, 1] = elements[[1]][1]
        stock_prices[i, 2] = elements[[1]][2]
        stock_prices[i, 3] = elements[[1]][3]
        stock_prices[i, 4] = elements[[1]][4]
        stock_prices[i, 5] = elements[[1]][5]
        stock_prices[i, 6] = elements[[1]][6]
      }
      
      stock_prices = stock_prices[-(1:7),]
      
      new_dates = grep(pattern = "a", x = stock_prices$DATE, value = F)
      new_dates_values = grep(pattern = "a", x = stock_prices$DATE, value = T)
      dates_list = as.POSIXct(as.numeric(gsub(pattern = "a", replacement = "", x = new_dates_values)), tz = "", origin = "1970-01-01")
      
      stock_prices$DATE_two = 0
      stock_prices$DATE_two[1] = stock_prices$DATE[new_dates[1]]
      
      if(length(new_dates) >= 2){
      for(i in 2:length(new_dates)){
        
        stock_prices$DATE_two[(new_dates[i-1]) : (new_dates[i] - 1)] = new_dates_values[i - 1]
      }}
      
      stock_prices$DATE_two[(new_dates[which.max(as.numeric(new_dates))]) : (nrow(stock_prices))] = new_dates_values[which.max(as.numeric(new_dates))]
      
      stock_prices$DATE_two = as.numeric(gsub(pattern = "a", replacement = "",x = stock_prices$DATE_two))
      stock_prices$DATE = as.numeric(gsub(pattern = "a", replacement = "",x = stock_prices$DATE))
      
      stock_prices$Date_Time = 0
      
      for(i in 1:nrow(stock_prices)){
        
        if(stock_prices$DATE[i] == stock_prices$DATE_two[i]){
          stock_prices$Date_Time[i] = stock_prices$DATE_two[i]
        }else{
          stock_prices$Date_Time[i] = stock_prices$DATE_two[i] + (stock_prices$DATE[i] * interval)
        }
      }
      
      stock_prices$Date_Time = as.POSIXct(x = stock_prices$Date_Time, tz = "", origin = "1970-01-01")
      
      stock_prices$DATE = stock_prices$Date_Time
      stock_prices = stock_prices[, -c(7,8)]
      
      stock_prices$DATE = as.POSIXct(as.numeric(stock_prices$DATE), tz = "", origin = "1970-01-01")
      
      if(interval >= 86400){
        stock_prices$DATE = as.Date(x = stock_prices$DATE, format = "%Y-%m-%d")
      }else{
        stock_prices$DATE = as.POSIXct(as.numeric(stock_prices$DATE), tz = "", origin = "1970-01-01")
      }

      stock_prices$CLOSE = as.numeric(stock_prices$CLOSE)
      stock_prices$HIGH = as.numeric(stock_prices$HIGH)
      stock_prices$LOW = as.numeric(stock_prices$LOW)
      stock_prices$OPEN = as.numeric(stock_prices$OPEN)
      stock_prices$VOLUME = as.numeric(stock_prices$VOLUME)
      stock_prices = stock_prices[,c(1,5,3,4,2,6)]
      
      colnames(stock_prices) = c("Date", "Open", "High", "Low", "Close", "Volume")
      if(sum(stock_prices$Volume, na.rm = T) == 0){stock_prices = stock_prices[,-6]}
      
      message(paste("Downloaded prices of", ticker, "from", stock_prices$Date[1], "to", stock_prices[nrow(stock_prices), 1], sep = " "))
      
      return(stock_prices)

}