$('#page-home-index').on 'page-load', ->
  backgrounds = ['kolaborasi.jpg', 'love_banten.jpg', 'teriak.jpg']
  loadedBg = []
  backgrounds.forEach (src) ->
    img = new Image()
    img.onload = () ->
      loadedBg.push this.src
    img.src = '/img/background/' + src
  iBg = 0
  setInterval () ->
    iBg = (iBg + 1) % loadedBg.length
    $('body').css 'background-image', 'url(' + loadedBg[iBg] + ')'

  , 5000

  $('#submit-dialog').on 'show.bs.modal', ->
    $('#testimony-hidden-field').val $('#testimony-field').val()

  currentTwitterId = null
  setPhotoTimeout = null
  setPhoto = ->
    twitterId = $('#twitter-field').val()
    if twitterId != currentTwitterId
      console.log "loading profile picture for @#{twitterId}"
      $.get '/testimony/twitter-photo/' + twitterId, (src) ->
        if src
          $('#twitter-photo').attr('src', src)
          $('#photo-hidden-field').val(src)
        else
          $('#twitter-photo').attr('src', '/img/dummy-person.jpg')
          $('#photo-hidden-field').val('')
      currentTwitterId = twitterId

  $('#twitter-field').on 'keyup', () ->
    if setPhotoTimeout
      clearTimeout setPhotoTimeout
    setPhotoTimeout = setTimeout setPhoto, 2000

  .on 'change', ->
    clearTimeout setPhotoTimeout
    setPhoto()