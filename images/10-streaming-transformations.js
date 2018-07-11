// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/06-connections-diagram.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot(600);
var blockWidth = width / 3.8;

var totalWorkers = 2;
var blockHeight = 170;

var streamingSorucesBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: blockHeight / 2,
  height: blockHeight,
  label: "Source Streams",
  childrens: [
    {label: "Kafka"},
    {label: "JDBC"},
    {label: "CSV"},
    {label: "..."}
  ]
});

var staticSorucesBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: height - blockHeight / 2,
  height: blockHeight,
  label: "Data Frames",
  childrens: [
    {label: "Parquet"},
    {label: "CSV"},
    {label: "JDBC"},
    {label: "..."}
  ]
});

var transformationBlock = drawBlock(root, {
  x: width / 2,
  y: height / 2,
  height: blockHeight,
  label: "Transformations",
  childrens: [
    {label: "dplyr"},
    {label: "SQL"},
    {label: "Pipeline"},
    {label: "R"}
  ]
});

linkBlocks(streamingSorucesBlock, transformationBlock);
linkBlocks(staticSorucesBlock, transformationBlock);

var destinationBlock = drawBlock(root, {
  x: width - blockWidth / 2,
  y: height / 2,
  height: blockHeight,
  label: "Destination Stream",
  childrens: [
    {label: "Kafka"},
    {label: "Memory"},
    {label: "CSV"},
    {label: "..."}
  ]
});

linkBlocks(transformationBlock, destinationBlock);
