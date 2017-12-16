console.log("JS loaded");
// Get the data
var raw_data = {'24': {'USD': 110, 'MXN': 2185, 'CAD': 148, 'EUR': 103, 'GBP': 90, 'PLN': 449, 'CHF': 111}, '25': {'USD': 99, 'MXN': 1980, 'CAD': 134, 'EUR': 94, 'GBP': 82, 'PLN': 407, 'CHF': 100}, '26': {'USD': 94, 'MXN': 1869, 'CAD': 127, 'EUR': 88, 'GBP': 77, 'PLN': 384, 'CHF': 95}, '27': {'USD': 96, 'MXN': 1920, 'CAD': 130, 'EUR': 91, 'GBP': 79, 'PLN': 394, 'CHF': 97}, '20': {'USD': 100, 'MXN': 1991, 'CAD': 135, 'EUR': 94, 'GBP': 82, 'PLN': 409, 'CHF': 101}, '21': {'USD': 100, 'MXN': 1994, 'CAD': 135, 'EUR': 94, 'GBP': 82, 'PLN': 410, 'CHF': 101}, '22': {'USD': 102, 'MXN': 2028, 'CAD': 137, 'EUR': 96, 'GBP': 84, 'PLN': 417, 'CHF': 103}, '23': {'USD': 102, 'MXN': 2044, 'CAD': 139, 'EUR': 97, 'GBP': 84, 'PLN': 420, 'CHF': 104}, '28': {'USD': 96, 'MXN': 1923, 'CAD': 130, 'EUR': 91, 'GBP': 79, 'PLN': 395, 'CHF': 98}, '29': {'USD': 96, 'MXN': 1908, 'CAD': 129, 'EUR': 90, 'GBP': 79, 'PLN': 392, 'CHF': 97}, '1': {'USD': 132, 'MXN': 2638, 'CAD': 179, 'EUR': 125, 'GBP': 109, 'PLN': 542, 'CHF': 134}, '0': {'USD': 139, 'MXN': 2759, 'CAD': 187, 'EUR': 131, 'GBP': 114, 'PLN': 567, 'CHF': 140}, '3': {'USD': 127, 'MXN': 2535, 'CAD': 172, 'EUR': 120, 'GBP': 105, 'PLN': 521, 'CHF': 129}, '2': {'USD': 130, 'MXN': 2600, 'CAD': 176, 'EUR': 123, 'GBP': 107, 'PLN': 534, 'CHF': 132}, '5': {'USD': 122, 'MXN': 2430, 'CAD': 165, 'EUR': 115, 'GBP': 100, 'PLN': 499, 'CHF': 123}, '4': {'USD': 125, 'MXN': 2490, 'CAD': 169, 'EUR': 118, 'GBP': 103, 'PLN': 512, 'CHF': 126}, '7': {'USD': 116, 'MXN': 2320, 'CAD': 157, 'EUR': 110, 'GBP': 96, 'PLN': 477, 'CHF': 118}, '6': {'USD': 120, 'MXN': 2384, 'CAD': 162, 'EUR': 113, 'GBP': 98, 'PLN': 490, 'CHF': 121}, '9': {'USD': 109, 'MXN': 2170, 'CAD': 147, 'EUR': 103, 'GBP': 89, 'PLN': 446, 'CHF': 110}, '8': {'USD': 112, 'MXN': 2233, 'CAD': 151, 'EUR': 106, 'GBP': 92, 'PLN': 459, 'CHF': 113}, '11': {'USD': 111, 'MXN': 2211, 'CAD': 150, 'EUR': 105, 'GBP': 91, 'PLN': 454, 'CHF': 112}, '10': {'USD': 108, 'MXN': 2158, 'CAD': 146, 'EUR': 102, 'GBP': 89, 'PLN': 443, 'CHF': 110}, '13': {'USD': 107, 'MXN': 2138, 'CAD': 145, 'EUR': 101, 'GBP': 88, 'PLN': 439, 'CHF': 109}, '12': {'USD': 105, 'MXN': 2099, 'CAD': 142, 'EUR': 99, 'GBP': 86, 'PLN': 431, 'CHF': 107}, '15': {'USD': 104, 'MXN': 2081, 'CAD': 141, 'EUR': 98, 'GBP': 86, 'PLN': 428, 'CHF': 106}, '14': {'USD': 109, 'MXN': 2179, 'CAD': 148, 'EUR': 103, 'GBP': 90, 'PLN': 448, 'CHF': 111}, '17': {'USD': 102, 'MXN': 2036, 'CAD': 138, 'EUR': 96, 'GBP': 84, 'PLN': 418, 'CHF': 103}, '16': {'USD': 101, 'MXN': 2018, 'CAD': 137, 'EUR': 95, 'GBP': 83, 'PLN': 414, 'CHF': 102}, '19': {'USD': 102, 'MXN': 2035, 'CAD': 138, 'EUR': 96, 'GBP': 84, 'PLN': 418, 'CHF': 103}, '18': {'USD': 101, 'MXN': 2016, 'CAD': 137, 'EUR': 95, 'GBP': 83, 'PLN': 414, 'CHF': 102}, '30': {'USD': 91, 'MXN': 1813, 'CAD': 123, 'EUR': 86, 'GBP': 75, 'PLN': 372, 'CHF': 92}};

var data = [];
for (var key in raw_data) {
    data.push(
    	{ [key] : raw_data[key] }
    );
};

var curSymbol = {
	'USD': '$',
	'MXN': 'MXN$',
	'CAD': 'CA$',
	'EUR': '€',
	'GBP': '£',
	'PLN': 'zł',
	'CHF': 'CHF',
}

//console.log(data);
//var xxx = data.map(d => console.log('xx: ' + Object.keys(data)))

var margin = {
    top: 30,
    right: 20,
    bottom: 50,
    left: 50
};
var width = 940 - margin.left - margin.right;
var height = 270 - margin.top - margin.bottom;
var padding = 100;
var selectedCurrency = 'USD';

var findPriceForCurr = function(d) {
	var dateKey = Object.keys(d)[0];
	return d[dateKey][selectedCurrency];
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

var yMin = d3.min(data, findPriceForCurr);
var yMax = d3.max(data, findPriceForCurr);

var y = d3.scaleLinear()
	.range([height, 0])
	.domain([yMin-10, yMax+10]);

// Define the axes
var xAxis = d3.axisBottom(x)
    .tickSize(0,0) // Inner, Outer
    .tickPadding(0);

var yAxis = d3.axisLeft(y)
    .ticks(8)
    .tickFormat( function(d) { return curSymbol[selectedCurrency] + d } )
    .tickSize(-width, 0)
    .tickPadding(10);

svg.append("g") // Add the X Axis
		.attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

svg.append("g") // Add the Y Axis
	.attr("class", "y axis")
  .call(yAxis)
  .call(customYAxis);

function customYAxis(g) {
  g.call(yAxis);
  g.select(".domain").remove();
  g.selectAll(".tick line").attr("stroke", "#777").attr("stroke-dasharray", "2,2");
}

// Define the line
var valueline = d3.line()
  .x(function (d) {
    return x(Object.keys(d)[0]);
  })
  .y(function (d) {
  	return y(findPriceForCurr(d));
  });

svg.append("path") // Add the valueline path.
	.attr("d", valueline(data));

svg.selectAll("dataPoint")
  .data(data)
  .enter()
  .append("circle")
  .attr("class", "point")
  .attr('r', 4)
  .attr("cx", d => x(Object.keys(d)[0]))
  .attr('cy', d => y(findPriceForCurr(d)));

svg.append("text")
  .attr("text-anchor", "middle")  // this makes it easy to centre the text as the transform is applied to the anchor
  .attr("transform", "translate("+ (width/2) +","+(height+(padding/3))+")")  // centre below axis
  .attr("class", "axisTitle")
  .text("Days until travel date");
