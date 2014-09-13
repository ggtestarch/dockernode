var express = require('express');
var os = require("os");
var PORT = 8080;

var app = express();

app.get('/', function (req, res) {
  res.send('Hello from ' + os.hostname() + ' at ' + new Date() + '\n');
});

app.listen(PORT);
