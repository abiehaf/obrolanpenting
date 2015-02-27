
module.exports = (db, DataTypes) ->

  Testimony = db.define 'Testimony',
    name:
      type: DataTypes.STRING(50)
      allowNull: false
      validate:
        len:
          args: [3, 50]
          msg: 'Nama terlalu pendek'

    title:
      type: DataTypes.STRING(50)

    email:
      type: DataTypes.STRING(100)
      allowNull: false
      validate:
        isEmail:
          msg: 'Format Salah'

    text:
      type: DataTypes.TEXT,
      allowNull:
        args: false
        msg: 'Testimoni tidak boleh kosong'

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

  , getterMethods:
      simplifiedName: ->
        name = @getDataValue('name') || ''
        return name.toLowerCase().replace(/\W+/g, '-').replace(/^-+|-+$/g, '')
# ,
#   classMethods:
#     associate (models) ->
#       models.a
# example on how to add relations
# Article.hasMany models.Comments

