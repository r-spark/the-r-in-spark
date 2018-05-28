// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/06-connections-diagram.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot(600);
var blockWidth = width / 4.0;

var totalWorkers = 3;
var blockHeight = height / totalWorkers - 10;

var sparklyrBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: blockHeight / 3,
  height: height / 4,
  label: "R",
  childrens: [{
    label: "sparklyr"
  }]
});

var driverBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: height / 2,
  height: height / 3 - 10,
  label: "Driver",
  childrens: [{
    label: "Livy Service"
  }, {
    label: "Spark Context"
  }]
});

linkBlocks(sparklyrBlock, driverBlock, "Web API");

var clusterBlock = drawBlock(root, {
  x: width / 2,
  y: height / 2,
  height: 30,
  label: "Cluster Manager"
});

linkBlocks(driverBlock, clusterBlock);

var workers = new Array(totalWorkers);
for (var i = 0; i < totalWorkers; i++) {
  workers[i] = drawBlock(root, {
    x: width - blockWidth / 2,
    y: 5 + blockHeight / 2 + height / totalWorkers * i,
    height: blockHeight,
    label: "Worker",
    childrens: [{
      label: "Spark Executor",
      color: "#759cc7"
    }, {
      label: "Spark Executor",
      color: "#759cc7"
    }]
  });
}

for (var i = 0; i < workers.length; i++) {
  linkBlocks(clusterBlock, workers[i]);
}
