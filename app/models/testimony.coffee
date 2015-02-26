
module.exports = (sequelize, DataTypes) ->

  Testimony = sequelize.define 'Testimony',
    name: DataTypes.STRING,
    email: DataTypes.STRING
    text: DataTypes.TEXT,
    url: DataTypes.STRING,
    photo: DataTypes.STRING,
  ,
    getterMethods:
      simplifiedName: ->
        this.name.toLowerCase().replace(/\W+/g, '-').replace(/^-+|-+$/g, '')
# ,
#   classMethods:
#     associate (models) ->
#       models.a
# example on how to add relations
# Article.hasMany models.Comments

