        // Set the dimensions of the canvas / graph
            // Main is for charts and mini is for slider which would be below the chart
            var main_margin = {top: 20, right: 80, bottom: 100, left: 40},
                mini_margin = {top: 430, right: 80, bottom: 20, left: 40},
                main_width = 960 - main_margin.left - main_margin.right,
                main_height = 500 - main_margin.top - main_margin.bottom,
                mini_height = 500 - mini_margin.top - mini_margin.bottom;

            // Parse the date / time
            var formatDate = d3.time.format("%d-%m"), 
                parseDate = formatDate.parse,
                bisectDate = d3.bisector(function(d) { return d.Date; }).left, 
                formatOutput0 = function(d) { return formatDate(d.Date) + " - " + d.Nifty; }, 
                formatOutput1 = function(d) { return formatDate(d.Date) + " - " + d.Sensex; };

            // Set the ranges for x 
            var main_x = d3.time.scale()
                .range([0, main_width]),
                mini_x = d3.time.scale()
                .range([0, main_width]);

            // Set the ranges for y
            var main_y0 = d3.scale.linear()
                .range([main_height, 0]),
                main_y1 = d3.scale.linear()
                .range([main_height, 0]),
                mini_y0 = d3.scale.linear()
                .range([mini_height, 0]),
                mini_y1 = d3.scale.linear()
                .range([mini_height, 0]);

            // Define the axes
            var main_xAxis = d3.svg.axis()
                .scale(main_x)
                .tickFormat(d3.time.format("%d-%m-%Y"))
                .orient("bottom"),
              
                mini_xAxis = d3.svg.axis() //this is for slider
                .scale(mini_x)
                .tickFormat(d3.time.format("%d-%m-%Y"))
                .orient("bottom");

            var main_yAxisLeft = d3.svg.axis()
                .scale(main_y0)
                .orient("left");
                main_yAxisRight = d3.svg.axis()
                .scale(main_y1)
                .orient("right");

            //Creating a slider
            var brush = d3.svg.brush()
                .x(mini_x)
                .on("brush", brush);

            // Define the line
            var main_line0 = d3.svg.line()
                .interpolate("cardinal")
                .x(function(d) { return main_x(d.Date); })
                .y(function(d) { return main_y0(d.Nifty); });

            var main_line1 = d3.svg.line()
                .interpolate("cardinal")
                .x(function(d) { return main_x(d.Date); })
                .y(function(d) { return main_y1(d.Sensex); });

            var mini_line0 = d3.svg.line()
                .x(function(d) { return mini_x(d.Date); })
                .y(function(d) { return mini_y0(d.Nifty); });

            var mini_line1 = d3.svg.line()
                .x(function(d) { return mini_x(d.Date); })
                .y(function(d) { return mini_y1(d.Sensex); });

            // Adds the svg canvas
            var svg = d3.select("body")
                              .append("svg")
                              .attr("width", main_width + main_margin.left + main_margin.right)
                              .attr("height", main_height + main_margin.top + main_margin.bottom)

                              svg.append("defs").append("clipPath")
                              .attr("id", "clip")
                              .append("rect")
                              .attr("width", main_width)
                              .attr("height", main_height);

            var main = svg.append("g")
                .attr("transform", "translate(" + main_margin.left + "," + main_margin.top + ")");
                

            var mini = svg.append("g")
                .attr("transform", "translate(" + mini_margin.left + "," + mini_margin.top + ")");


            // Get the data
            d3.json("https://rawgit.com/vishukapoor/Syllexa/gh-pages/Syllexa.github.io/Market-Movement/data.json", function(error, data) {
              data.forEach(function(d) {
                d.Date = parseDate(d.Date);
                d.Nifty = +d.Nifty;
                d.Sensex = +d.Sensex;
              });

              data.sort(function(a, b) {
                return a.Date - b.Date;
              });

            // Scale the range of the data
              main_x.domain([data[0].Date, data[data.length - 1].Date]);
              main_y0.domain(d3.extent(data, function(d) { return d.Nifty; }));
              main_y0.domain([0.1, d3.max(data, function(d) { return d.Nifty; })]);
              main_y1.domain(d3.extent(data, function(d) { return d.Sensex; }));
              mini_x.domain(main_x.domain());
              mini_y0.domain(main_y0.domain());
              mini_y1.domain(main_y1.domain());

            // Add the valueline path.
              main.append("path")
                  .datum(data)
                  .attr("clip-path", "url(#clip)")
                  .attr("class", "line line0")
                  .attr("d", main_line0);

              main.append("path")
                  .datum(data)
                  .attr("clip-path", "url(#clip)")
                  .attr("class", "line line1")
                  .attr("d", main_line1);

            // Add the X Axis
              main.append("g")
                  .attr("class", "x axis")
                  .attr("transform", "translate(0," + main_height + ")")
                  .call(main_xAxis);

            // Add the Y1 Axis
              main.append("g")
                  .attr("class", "y axis axisLeft")
                  .call(main_yAxisLeft)
                .append("text")
                  .attr("transform", "rotate(-90)")
                  .attr("y", 6)
                  .attr("dy", ".71em")
                  .style("text-anchor", "end")
                  .text("Nifty");

            // Add the Y2 Axis
              main.append("g")
                  .attr("class", "y axis axisRight")
                  .attr("transform", "translate(" + main_width + ", 0)")
                  .call(main_yAxisRight)
                .append("text")
                  .attr("transform", "rotate(-90)")
                  .attr("y", -12)
                  .attr("dy", ".71em")
                  .style("text-anchor", "end")
                  .text("Sensex");


            // Add the valueline path for slider
              mini.append("path")
                  .datum(data)
                  .attr("class", "line")
                  .attr("d", mini_line0);

              mini.append("path")
                  .datum(data)
                  .attr("class", "line")
                  .attr("d", mini_line1);

              mini.append("g")
                  .attr("class", "x brush")
                  .call(brush)
                .selectAll("rect")
                  .attr("y", -6)
                  .attr("height", mini_height + 7);

              var focus = main.append("g")
                  .attr("class", "focus")
                  .style("display", "none");

              // Display on the timeline
              focus.append("line")
                  .attr("class", "x")
                  .attr("y1", main_y0(0) - 6)
                  .attr("y2", main_y0(0) + 6)

              // Display on the left bar
              focus.append("line")
                  .attr("class", "y0")
                  .attr("x1", main_width - 6) // nach links
                  .attr("x2", main_width + 6); // nach rechts

              // Ad on the right bar
              focus.append("line")
                  .attr("class", "y1")
                  .attr("x1", main_width - 6)
                  .attr("x2", main_width + 6);

            // append the circle at the intersection
              focus.append("circle")
                  .attr("class", "y0")
                  .attr("r", 4);

            // append the text at the intersection of x axis and y0
              focus.append("text")
                  .attr("class", "y0")
                  .attr("dy", "-1em");

            // append the circle at the intersection
              focus.append("circle")
                  .attr("class", "y1")
                  .attr("r", 4);
            // append the text at the intersection of x axis and y1
              focus.append("text")
                  .attr("class", "y1")
                  .attr("dy", "-1em");

            // The rectangle for slider
              main.append("rect")
                  .attr("class", "overlay")
                  .attr("width", main_width)
                  .attr("height", main_height)
                  .on("mouseover", function() { focus.style("display", null); })
                  .on("mouseout", function() { focus.style("display", "none"); })
                  .on("mousemove", mousemove);

            //Mouse move function for creating a slider
              function mousemove() {
                var x0 = main_x.invert(d3.mouse(this)[0]),
                    i = bisectDate(data, x0, 1),
                    d0 = data[i - 1],
                    d1 = data[i],
                    d = x0 - d0.Date > d1.Date - x0 ? d1 : d0;
                focus.select("circle.y0").attr("transform", "translate(" + main_x(d.Date) + "," + main_y0(d.Nifty) + ")");
                focus.select("text.y0").attr("transform", "translate(" + main_x(d.Date) + "," + main_y0(d.Nifty) + ")").text(formatOutput0(d));
                focus.select("circle.y1").attr("transform", "translate(" + main_x(d.Date) + "," + main_y1(d.Sensex) + ")");
                focus.select("text.y1").attr("transform", "translate(" + main_x(d.Date) + "," + main_y1(d.Sensex) + ")").text(formatOutput1(d));
                focus.select(".x").attr("transform", "translate(" + main_x(d.Date) + ",0)");
                focus.select(".y0").attr("transform", "translate(" + main_width * -1 + ", " + main_y0(d.Nifty) + ")").attr("x2", main_width + main_x(d.Date));
                focus.select(".y1").attr("transform", "translate(0, " + main_y1(d.Sensex) + ")").attr("x1", main_x(d.Date));
              }
            });

            function brush() {
              main_x.domain(brush.empty() ? mini_x.domain() : brush.extent());
              main.select(".line0").attr("d", main_line0);
              main.select(".line1").attr("d", main_line1);
              main.select(".x.axis").call(main_xAxis);
            }
