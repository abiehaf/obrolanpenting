
passport = require('passport')
LocalStrategy = require('passport-local').Strategy

db = require './models'

passport.use new LocalStrategy {usernameField: 'email'}, (email, password, done) ->
  db.User.findOne { email: email }, (err, user) ->
    if err
      done(err)
    else if not user or not user.passwordIsValid(password)
      done null, false, { message: 'Incorrect user or password.' }
    else
      done null, user
