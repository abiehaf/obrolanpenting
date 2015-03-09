db = require '../models'
request = require 'request'
cheerio = require 'cheerio'
Q = require 'q'
extend = require 'extend'

navMenus = [{name: 'home.index', 'label': 'Home'}, {name: 'home.about', 'label': 'Tentang Kami'}]

getTwitterPhoto = (id, cb) ->
  request 'https://twitter.com/' + id, (err, res, body) ->
    console.log err, res.statusCode, body
    if err
      cb err
    else if res.statusCode != 200
      cb(new Error('Http code: ' + res.statusCode))
    else
      $ = cheerio.load body
      cb null, $('.ProfileAvatar img').attr('src')


module.exports = (route, app) ->

  route 'testimony.post', '/testimony/post', (req, res) ->
    save = (params) ->
      db.Testimony.create params
      .then (testimony) ->
        res.send
          link: route.createLink('testimony.view', {name: 'abi-hafshin', id: testimony.id})
      .catch (err) ->
        if err.name is 'SequelizeValidationError'
          res.json errors: err.errors
        else
          res.error err
    params = req.body
    if params.twitter
      params.url = 'https://twitter.com/' + params.twitter
    if params.twitter and ! params.photo
      getTwitterPhoto params.twitter, (err, photo) ->
        params.photo = photo
        save params
    else
      save params


  route 'testimony.twitter.photo', '/testimony/twitter-photo/:id', (req, res) ->
    getTwitterPhoto req.params.id, (err, photo) ->
      console.log err, photo
      if err
        res.error err
      else
        res.send photo

  defaultFindArg = {
    where:
      shown: true
    order: 'point DESC, "createdAt" DESC'
    limit: 18
  }

  route 'testimony.index', '/banten-menurut-mereka', (req, res) ->
    db.Testimony.findAll(defaultFindArg).success (testimonies) ->
      res.render 'testimony/index',
        title: 'Banten Menurut Mereka - Obrolan Penting'
        testimonies: testimonies

  route 'testimony.view', '/banten-menurut-:name--:id', (req, res) ->
    param = extend(true, {}, defaultFindArg, {where: {id: {ne: req.params.id}}})
    Q.all [
      db.Testimony.find(req.params.id)
      db.Testimony.findAll(param)
    ]
    .spread (testimony, testimonies) ->
      if testimony.shown
        testimony.point++
        testimony.save()
      res.render 'testimony/view',
        title: "Banten Menurut #{testimony.name} - Obrolan Penting"
        testimony: testimony
        testimonies: testimonies
