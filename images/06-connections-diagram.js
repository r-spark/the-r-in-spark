
svg.append("svg:defs").append("svg:marker")
  .attr("id", "circle")
  .attr("refX", 6)
  .attr("refY", 6)
  .attr("markerWidth", 12)
  .attr("markerHeight", 12)
  .attr("orient", "auto")
  .append("circle")
  .attr("cx", "6")
  .attr("cy", "6")
  .attr("r", "3")
  .attr("class", "block-link")
  .attr("stroke-width", 1);

function diagramRoot(maxWidth) {
  if (!maxWidth) maxWidth = 500;

  var scaleX = 1;
  var scaleY = 1;
  height = height - 20;

  var newWidth = width > maxWidth ? maxWidth : width;
  var translateX = width > newWidth ? (width - newWidth) / 2 : 0;
  var translateY = 10;
  width = newWidth;

  svg
    .attr("font-size", Math.min(width, 500) / 600 + "em")
    .attr("font-family", "sans-serif");

  var root = svg.append("g")
    .attr("transform", "translate(" + translateX + "," + translateY + ")scale(" + scaleX + "," + scaleY + ")");

  return root;
}

function drawBlock(parent, block) {
  if (!block.x) block.x = 0;
  if (!block.y) block.y = 0;
  if (!block.width) block.width = blockWidth;
  if (!block.height) block.height = blockHeight;
  if (!block.color) block.color = "#86aedb";
  if (!block.label) block.label = "<label>";
  if (!block.style) block.style = "block";

  var startX = block.x - block.width / 2;
  var startY = block.y - block.height / 2;

  parent.append("rect")
    .attr("x", startX)
    .attr("y", startY)
    .attr("width", block.width)
    .attr("height", block.height)
    .attr("class", block.style);

  var current = parent.append("text")
    .attr("x", block.x)
    .attr("y", startY + 20)
    .attr("fill", "white")
    .attr("text-anchor", "middle")
    .text(block.label);

  if (block.childrens) {
    var posY = 46;
    for (var childIdx in block.childrens) {
      var child = block.childrens[childIdx];

      var childBlock = {
        x: block.x,
        y: startY + posY,
        width: block.width - 20,
        height: 30,
        label: child.label,
        style: "block-children"
      };

      drawBlock(parent, childBlock);

      posY += 34;
    }
  }

  return block;
}

function linkBlocks(block1, block2, label) {
  var block1right = block1.x + block1.width / 2;
  var block2left = block2.x - block2.width / 2;
  var block1bottom = block1.y + block1.height / 2;
  var block2top = block2.y - block2.height / 2;

  var horizontal = block1right < block2left;

  root.append('line')
    .attr("x1", horizontal ? block1right : block1.x)
    .attr("y1", horizontal ? block1.y : block1bottom)
    .attr("x2", horizontal ? block2left : block2.x)
    .attr("y2", horizontal ? block2.y : block2top)
  	.attr("class", "block-link")
  	.attr("stroke-width", "1")
  	.attr("marker-start", "url(#circle)")
  	.attr("marker-end", "url(#circle)")
  	.attr("stroke-dasharray", "3,7");

  var labelFits = horizontal ?
    Math.abs(block2left - block1right) > block1.width / 2 :
    Math.abs(block2top - block1bottom) > 30;

  if (label && labelFits) {
    root.append('text')
      .attr("dy", (horizontal ? "-" : "") + "0.4em")
      .attr("x", block1right + (block2left - block1right) / 2)
      .attr("y", block1bottom + (block2top - block1bottom) / 2)
      .attr("text-anchor", "middle")
      .attr("fill", "#759cc7")
      .text(label);
  }
}
