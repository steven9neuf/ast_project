
// Function to draw graph
function drawGraph(raw_data) {
  var data = [];
  for (var key in raw_data) {
      data.push(
      	{ [key] : raw_data[key] }
      );
  };

  var margin = {
      top: 30,
      right: 20,
      bottom: 50,
      left: 50
  };
  var width = 940 - margin.left - margin.right;
  var height = 270 - margin.top - margin.bottom;
  var padding = 100;
  var selectedCurrency = 'key';

  var getValue = function(d) {
  	var objectKey = Object.keys(d)[0];
    var date = d[objectKey].value;// formatDate(d[objectKey].value*1000);
  	return date;
  }

  // Adds the svg canvas
  var svg = d3.select("#d3Chart")
      .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  // Set the ranges
  var x = d3.scalePoint()
  	.range([0, width])
    .domain(data.map(d => Object.keys(d)[0]));

  var yMin = d3.min(data, getValue);
  var yMax = d3.max(data, getValue);

  var y = d3.scaleTime()
    .domain([yMin, yMax])
    .range([height, 0]);

  // Define the axes
  var xAxis = d3.axisBottom(x)
      .tickSize(0,0) // Inner, Outer
      .tickPadding(0);

  var yAxis = d3.axisLeft(y)
      .ticks(d3.timeYear)
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
      return x(Object.keys(d)[0]);
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
    .attr("cx", d => x(Object.keys(d)[0]))
    .attr('cy', d => y(getValue(d)));

  // Write text
  svg.append("text")
    .attr("text-anchor", "middle")
    .attr("transform", "translate("+ (width/2) +","+(height+(padding/3))+")")
    .attr("class", "axisTitle")
    .text("Dates from metric");
  }
