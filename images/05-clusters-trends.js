// !preview r2d3 data=read.csv("data/05-cluster-trends.csv") %>% mutate(month = as.Date(paste(month, "-01", sep = "")))

var scaleX = d3.scaleTime()
  .domain([new Date(2004, 1, 1), new Date(2018, 6, 1)])
  .range([0, width]);

var axisHeight = 20;
var axisX = d3.axisBottom(scaleX)
  .ticks(10);

var scaleY = d3.scaleLinear()
  .domain([0, 100])
  .range([height - axisHeight, 20]);

var chartScale = "scale(0.88, 1)";

svg
  .append("g")
  .attr("transform", "translate(0," + (height - axisHeight) + ")" + chartScale)
  .call(axisX);

svg.selectAll(".domain").attr("stroke", theme.foreground);
svg.selectAll(".tick text").attr("fill", theme.foreground);
svg.selectAll(".tick line").attr("stroke", theme.foreground);

var addLine = function(label, secondary, color, accessorX, accessorY) {
  svg.append("path")
    .attr("transform", chartScale)
    .data([data])
    .attr("fill", "none")
    .attr("stroke", color)
    .attr("stroke-width", 1.5)
    .attr("d", d3.line()
      .x(function(d) { return scaleX(new Date(accessorX(d))); })
      .y(function(d) { return scaleY(parseInt(accessorY(d))); })
    );

  var text = svg
    .data([data])
    .datum(function(d) { return d[d.length - 1]; })
    .attr("font-size", Math.min(width / 900, 0.8) + "em")
    .attr("font-family", "sans-serif");

  text.append("text")
      .attr("dy", "0.4em")
      .attr("x", width * 0.88)
      .attr("y", function(d) { return scaleY(parseInt(accessorY(d))); })
      .attr("fill", color)
      .text(label);

  text.append("text")
      .attr("dy", "1.4em")
      .attr("x", width * 0.88)
      .attr("y", function(d) { return scaleY(parseInt(accessorY(d))); })
      .attr("fill", color)
      .text(secondary);
};

addLine("Cloud", "Computing", "steelblue", function(d) { return d.month; } , function(d) { return d["cloud.computing"]; });
addLine("On-Premise", "(Mainframe)", "orange", function(d) { return d.month; } , function(d) { return d.mainframe; });
addLine("Kubernetes", "", "green", function(d) { return d.month; } , function(d) { return d.kubernetes; });
