// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/07-tuning-spark-overview.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot(600);
var blockWidth = width / 7.0;

var totalWorkers = 3;
var blockHeight = height / totalWorkers - 10;

var stages = [
  [
    [4, 9, 1],
    [8, 2, 3],
    [5, 7, 6]
  ],
  [
    [1, 4, 9],
    [2, 3, 8],
    [5, 6, 7]
  ],
  [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]
];

var storageBlocks = new Array(totalWorkers);
for (var i = 0; i < totalWorkers; i++) {
  var children = new Array(stages[0][i].length);
  for (var j = 0; j < children.length; j++) {
    children[j] = {
      label: stages[0][i][j],
      width: blockWidth - 40,
      style: "block-data-children"
    };
  }

  storageBlocks[i] = drawBlock(root, {
    x: blockWidth / 2,
    y: 5 + blockHeight / 2 + height / totalWorkers * i,
    width: blockWidth * 0.8,
    height: blockHeight,
    label: "Data",
    childrens: children,
    style: "block-data"
  });
}

var stage1 = new Array(totalWorkers);
for (var i = 0; i < totalWorkers; i++) {
  var children = new Array(stages[0][0].length + stages[1][0].length + 1);
  for (var j = 0; j < stages[0][0].length; j++) {
    children[j] = {
      label: stages[0][i][j],
      width: blockWidth - 40,
      x: blockWidth * (2 - 1 / 2),
      position: j
    };
  }

  children[children.length - 1] = {
    label: "f(x)",
    width: blockWidth * 0.7 - 40,
    style: "block-data-children",
    position: 1
  };

  for (var j = 0; j < stages[1][0].length; j++) {
    children[j + stages[0][0].length] = {
      label: stages[1][i][j],
      width: blockWidth - 40,
      x: blockWidth * (2 + 1 / 2),
      position: j
    };
  }

  stage1[i] = drawBlock(root, {
    x: blockWidth * (2),
    y: 5 + blockHeight / 2 + height / totalWorkers * i,
    width: blockWidth * 2,
    height: blockHeight,
    label: "Worker",
    childrens: children
  });
}

var stage2 = new Array(totalWorkers);
for (var i = 0; i < totalWorkers; i++) {
  var children = new Array(stages[2][i].length);
  for (var j = 0; j < children.length; j++) {
    children[j] = {
      label: stages[2][i][j],
      width: blockWidth - 40,
      x: blockWidth * (7 - 1 / 2)
    };
  }

  stage2[i] = drawBlock(root, {
    x: blockWidth * (7 - 1/2),
    y: 5 + blockHeight / 2 + height / totalWorkers * i,
    width: blockWidth,
    height: blockHeight,
    label: "Worker",
    childrens: children
  });
}

for (var i = 0; i < stage1.length; i++) {
  for (var j = 0; j < stage2.length; j++) {
    linkBlocks(stage1[i], stage2[j]);
  }
}
