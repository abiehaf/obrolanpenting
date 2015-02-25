db = require '../models'
request = require 'request'
cheerio = require 'cheerio'

navMenus = [{name: 'home.index', 'label': 'Home'}, {name: 'home.about', 'label': 'Tentang Kami'}]

getTwitterPhoto = (id, cb) ->
  request 'https://twitter.com/' + id, (err, res, body) ->
    if err
      cb err
    else if res.statusCode is not 200
      cb new Error('Http code: ' + res.statusCode)
    else
      $ = cheerio.load body
      cb null, $('.ProfileAvatar img').attr('src')


module.exports = (route, app) ->

  route 'testimony.post', '/testiomny/post', (req, res, next) ->
    save = (params) ->
      db.Testimony.create params
      .catch (error) ->
        console.trace error
        next error
      .then (testimony) -> res.redirect route.createLink('testimony.view', {name: 'abi-hafshin', id: testimony.id})
    params = req.body
    if params.twitter
      params.url = 'https://twitter.com/' + params.twitter
    if params.twitter and ! params.photo
      getTwitterPhoto params.twitter, (photo) ->
        params.photo = photo
        save params
    else
      save params


  route 'testimony.twitter.photo', '/testimony/twitter-photo/:id', (req, res) ->
    getTwitterPhoto req.params.id, (err, photo) ->
      if err
        console.trace err
        next err
      else
        res.send photo


  route 'testimony.index', '/banten-menurut-mereka', (req, res, next) ->
    db.Testimony.findAll().success (testimonies) ->
      res.render 'testimony/index',
        title: 'Generator-Express MVC'
        testimonies: testimonies

  route 'testimony.view', '/banten-menurut-:name--:id', (req, res, next) ->
    console.log req.params
    res.render 'testimony/view'

