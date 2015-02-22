require('coffee-script/register');

var express = require('express'),
  config = require('./app/config'),
  db = require('./app/models');

var app = express();

require('./app')(app, config);

db.sequelize
  .sync()
  .then(function () {
    app.listen(config.port);
  }).catch(function (e) {
    throw new Error(e);
  });

