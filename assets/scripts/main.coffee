


jQuery ($) ->
  backgrounds = ['kolaborasi.jpg', 'love_banten.jpg', 'teriak.jpg']
  console.log backgrounds
  iBg = 0
  setInterval () ->
    iBg = (iBg + 1) % backgrounds.length
    console.log iBg
    $('body').css 'background-image', 'url(/img/background/' + backgrounds[iBg] + ')'

  , 5000


