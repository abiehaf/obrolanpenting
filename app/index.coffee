express = require 'express'
glob = require 'glob'

favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'

module.exports = (app, config) ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

  #app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use compress()
  app.use express.static config.root + '/public'
  app.use methodOverride()

  routerMap = {}
  router = express.Router()
  _route = (method, name, url, handler) ->
    routerMap[name] = url
    router[method] url, (req, res, next) ->
      req.router_name = name
      handler req, res, next
  route = (name, url, handler) -> _route('all', name, url, handler)
  route.get = (name, url, handler) -> _route('get', name, url, handler)
  route.post = (name, url, handler) -> _route('post', name, url, handler)
  route.createLink = (name, params) ->
    url = routerMap[name]
    if url and params
      for k, v of params
        url = url.replace(':' + k, v)
    return url

  app.locals.DEBUG = app.get('env') == 'development'
  app.locals.link = route.createLink

  app.use (req, res, next) ->
    app.locals.req = req
    next()

  app.use '/', router
  controllers = glob.sync config.root + '/app/controllers/**/*.coffee'
  controllers.forEach (controller) ->
    require(controller)(route, app)

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    req.router_name = 'site.error'
    err = new Error 'Not Found'
    err.status = 404
    next err

  # error handlers

  # development error handler
  # will print stacktrace
  
  if app.get('env') == 'development'
    app.use (err, req, res, next) ->
      res.status err.status || 500
      res.render 'error',
        message: err.message
        error: err
        title: 'error'

  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: {}
      title: 'error'
