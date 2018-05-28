// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/06-connections-diagram.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot(600);
var blockWidth = width / 4.0;

var totalWorkers = 3;
var blockHeight = height / totalWorkers - 10;

var driverBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: height / 2,
  height: 150,
  label: "Driver",
  childrens: [{
    label: "R"
  }, {
    label: "sparklyr"
  }, {
    label: "Spark Context"
  }]
});

var clusterBlock = drawBlock(root, {
  x: width / 2,
  y: height / 2,
  height: 80,
  label: "Cluster Manager",
  childrens: [{
    label: "Mesos"
  }]
});

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

linkBlocks(driverBlock, clusterBlock);
for (var i = 0; i < workers.length; i++) {
  linkBlocks(clusterBlock, workers[i]);
}
