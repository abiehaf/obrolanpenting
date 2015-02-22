path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

module.exports = 
  root: path.normalize __dirname + '/..'
  env: process.env.NODE_ENV || 'development'
  app:
    name: 'beta'
  port: process.env.PORT || 3000
  db: process.env.DATABASE_URL || 'postgres://username:password@localhost/db'
