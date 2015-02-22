# Example model


module.exports = (sequelize, DataTypes) ->

  Article = sequelize.define 'Article',
    title: DataTypes.STRING,
    url: DataTypes.STRING,
    text: DataTypes.STRING
  # ,
  #   classMethods:
  #     associate (models) ->
  #       models.a
        # example on how to add relations
        # Article.hasMany models.Comments

