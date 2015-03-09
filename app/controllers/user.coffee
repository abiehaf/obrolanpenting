
passport = require('passport')


module.exports = (route, app) ->
  route 'user.login', '/user/login', (req, res) ->
    res.render 'user/login'

  route 'user.do_login', passport.authenticate 'local',
    successRedirect: route.createLink('home.index')
    failureRedirect: route.createLink('user.login')
    failureFlash: true
