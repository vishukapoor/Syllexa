  g2 = new Dygraph(
    document.getElementById("graphdiv2"),
    "https://raw.githubusercontent.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/Market-Movement/data.csv", // path to CSV file
  {
    legend: 'always',
    title: 'Market Movement',
    showRangeSelector: true,
    showInRangeSelector: true,
    //dateWindow: [01-01-2015,]
    animatedZooms: true, 
    labels: ["Date", "Nifty", "Sensex"],
    Nifty : {
  axis : { }
  }
    
   }         

  );
