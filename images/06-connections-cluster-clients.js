// !preview r2d3 dependencies="images/06-connections-diagram.js", css="images/06-connections-diagram.css"
//
// r2d3: https://rstudio.github.io/r2d3
//

var root = diagramRoot();
var blockWidth = width / 3.0;

var blockHeight = height - 10;

var driverBlock = drawBlock(root, {
  x: blockWidth / 2,
  y: height / 2,
  height: blockHeight,
  label: "Client",
  childrens: [{
    label: "Terminal"
  }, {
    label: "Web Borwser"
  }]
});

var edgeBlock = drawBlock(root, {
  x: width - blockWidth / 2,
  y: height / 2,
  height: blockHeight,
  label: "Edge",
  childrens: [{
    label: "Secure Shell Server"
  }, {
    label: "Web Server"
  }, {
    label: "RStudio Server"
  }]
});

linkBlocks(driverBlock, edgeBlock, "Secure Shell / HTTP");
