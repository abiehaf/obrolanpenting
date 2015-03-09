bcrypt = require 'bcrypt'

module.exports = (sequelize, DataTypes) ->

  User = sequelize.define 'User',
    name:
      type: DataTypes.STRING(50)
      allowNull: false
      validate:
        len:
          args: [3, 50]
          msg: 'Nama terlalu pendek'

    email:
      type: DataTypes.STRING(100)
      allowNull: false
      validate:
        isEmail:
          msg: 'Format Salah'

    password:
      type: DataTypes.VIRTUAL
      set: (val) ->
        salt = bcrypt.genSaltSync(10)
        @setDataValue 'password', val
        @setDataValue 'password_hash', bcrypt.hash(val, salt)
      allowNull:
        args: false
        msg: 'Testimoni tidak boleh kosong'
      validate:
        len:
          args: [4, 50]
          msg: 'Password terlalu pendek'

    password_hash:
      type: DataTypes.STRING(100)

    url:
      type: DataTypes.STRING,
      validate:
        isUrl: true

    photo:
      type: DataTypes.STRING,
      validate:
        isUrl: true
      get: ->
        return @getDataValue('photo') || '/img/dummy-person.jpg'

    role:
      type: DataTypes.STRING(10)
      default: false



  , instanceMethod:
      passwordIsValid: (password, cb) ->
        bcrypt.compare(@getDataValue('password_hash'), password, cb)
# ,
#   classMethods:
#     associate (models) ->
#       models.a
# example on how to add relations
# Article.hasMany models.Comments

