// !preview r2d3 data=read.csv("data/clusters-trends.csv") %>% mutate(month = as.Date(paste(month, "-01", sep = "")))

function drawAll(width, height, animate) {
  var scaleX = d3.scaleTime()
    .domain([new Date(2004, 1, 1), new Date(2018, 6, 1)])
    .range([0, width]);

  var axisHeight = height / 20;
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

  svg.selectAll(".tick text")
    .attr("fill", theme.foreground)
    .attr("font-size", (axisHeight / 20) + "em");

  svg.selectAll(".tick line").attr("stroke", theme.foreground);

  var lines = svg.append("g");

  var addLine = function(label, secondary, color, duration, delay, accessorX, accessorY) {
    var paths = lines.append("path")
      .attr("transform", chartScale)
      .data([data])
      .attr("fill", "none")
      .attr("class", "chart-line")
      .attr("stroke", color)
      .attr("stroke-width", 1.5)
      .attr("d", d3.line()
        .x(function(d) { return scaleX(new Date(accessorX(d))); })
        .y(function(d) { return scaleY(parseInt(accessorY(d))); })
      );

    var totalLength = paths.node().getTotalLength();

    paths
      .attr("stroke-dasharray", totalLength)
      .attr("stroke-dashoffset", totalLength)
      .transition()
        .duration(duration)
        .delay(delay)
        .ease(d3.easeLinear)
        .attr("stroke-dashoffset", 0);

    var text = lines
      .data([data])
      .datum(function(d) { return d[d.length - 1]; })
      .attr("font-size", Math.min(width / 900, 1.6) + "em")
      .attr("font-family", "sans-serif")
      .attr("class", "chart-line");

    text.append("text")
        .attr("dy", "0.4em")
        .attr("x", width * 0.88)
        .attr("y", function(d) { return scaleY(parseInt(accessorY(d))); })
        .attr("fill", color)
        .attr("class", "chart-line")
        .text(label);

    text.append("text")
        .attr("dy", "1.4em")
        .attr("x", width * 0.88)
        .attr("y", function(d) { return scaleY(parseInt(accessorY(d))); })
        .attr("fill", color)
        .attr("class", "chart-line")
        .text(secondary);

  };

  function drawLines(animate) {
    addLine(
      "On-Premise",
      "(Mainframe)",
      "orange",
      animate ? 2000 : 0,
      0,
      function(d) { return d.month; } , function(d) { return d.mainframe; });

    addLine(
      "Cloud",
      "Computing",
      "steelblue",
      animate ? 2000 : 0,
      animate ? 1000 : 0,
      function(d) { return d.month; } , function(d) { return d["cloud.computing"]; });

    addLine(
      "Kubernetes",
      "",
      "green",
      animate ? 2000 : 0,
      animate ? 2000 : 0,
      function(d) { return d.month; } , function(d) { return d.kubernetes; });
  }

  drawLines(animate);
}

drawAll(width, height, true);

r2d3.onResize(function(width, height) {
  svg.selectAll("g").remove();
  drawAll(width, height, false);
});
