// Default variables
var margin = {
    top: 30,
    right: 20,
    bottom: 50,
    left: 50
};

var width = 800 - margin.left - margin.right;
var height = 270 - margin.top - margin.bottom;
var padding = 100;

// Function to extract timestamp from key
var getTimestamp = function(d) {
  var objectKey = Object.keys(d)[0];
  var temp = [];
  temp = d[objectKey].key.split(":");
  return temp[2];
}

// Function to get value
var getValue = function(d) {
  var objectKey = Object.keys(d)[0];
  var value = d[objectKey].value;
  return value/1000000000; //TODO à enlever
}

// Function to draw graph
function drawGraph(raw_data) {
  var data = [];
  for (var key in raw_data) {
      data.push(
      	{ [key] : raw_data[key] }
      );
  };

  // Adds the svg canvas
  var svg = d3.select("#d3Chart")
      .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  // Set the ranges
  var xMin = d3.min(data, getTimestamp);
  var xMax = d3.max(data, getTimestamp);

  var yMin = d3.min(data, getValue);
  var yMax = d3.max(data, getValue);

  var x = d3.scaleTime()
    .range([width, 0])
    .domain([xMin, xMax]);

  var y = d3.scaleLinear()
    .range([height, 0])
    .domain([yMin-10, yMax+10]);

  // Define the axes
  var xAxis = d3.axisBottom(x)
      .ticks(d3.timeYear)
      .tickSize(0,0)
      .tickPadding(0);

  var yAxis = d3.axisLeft(y)
      .tickSize(-width, 0)
      .tickPadding(10);

  // Add the X Axis
  svg.append("g")
  		.attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  // Add the Y Axis
  svg.append("g")
  	.attr("class", "y axis")
    .call(yAxis)
    .call(customYAxis);

  // Add dash lines to Y axis
  function customYAxis(g) {
    g.call(yAxis);
    g.select(".domain").remove();
    g.selectAll(".tick line").attr("stroke", "#777").attr("stroke-dasharray", "2,2");
  }

  // Draw line
  var valueline = d3.line()
    .x(function (d) {
      return x(getTimestamp(d));
    })
    .y(function (d) {
    	return y(getValue(d));
    });

  // Draw line to link data points
  svg.append("path")
  	.attr("d", valueline(data));

  // Draw data points
  svg.selectAll("dataPoint")
    .data(data)
    .enter()
    .append("circle")
    .attr("class", "point")
    .attr('r', 4)
    .attr("cx", d => x(getTimestamp(d)))
    .attr('cy', d => y(getValue(d)));

  // Write text
  svg.append("text")
    .attr("text-anchor", "middle")
    .attr("transform", "translate("+ (width/2) +","+(height+(padding/3))+")")
    .attr("class", "axisTitle")
    .text("Dates from metrics");
  }
