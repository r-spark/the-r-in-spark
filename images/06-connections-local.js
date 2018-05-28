// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/06-connections-diagram.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot();
var blockWidth = width / 3.5;
var blockHeight = Math.min(140, height * 0.8);

var driverBlock = drawBlock(root, {
  x: width / 2,
  y: height / 2,
  height: height,
  label: "Driver",
  childrens: [{
    label: "R"
  }, {
    label: "sparklyr"
  }, {
    label: "Spark Context"
  }, {
    label: "Spark Executor"
  }]
});

