var express = require('express');
var morgan = require('morgan')
var os = require("os");
var PORT = 8080;

var app = express();
app.use(morgan('combined'))

app.get('/', function (req, res) {
  res.send('Hello from ' + os.hostname() + ' at ' + new Date() + '\n');
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
