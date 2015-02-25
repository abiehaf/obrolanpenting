
navMenus = [{name: 'home.index', 'label': 'Home'}, {name: 'home.about', 'label': 'Tentang Kami'}]


module.exports = (route) ->
  route 'home.index', '/', (req, res, next) ->
    res.render 'home/index',
      body_class: 'layout-home page-index'
      navMenus: navMenus
      title: 'Obrolan Penting'
    #db.Article.findAll().success (articles) ->
    #  res.render 'index',
    #    title: 'Generator-Express MVC'
    #    articles: articles

  route 'home.about', '/about', (req, res, next) ->
    res.render 'home/about',
      body_class: 'layout-home page-about'
      navMenus: navMenus
      title: 'Siapa Kami? - Obrolan Penting'
