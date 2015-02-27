
$(document).ready ->
  $(document.body).trigger 'page-load'

  $('.ajax-form').on 'submit', (ev) ->
    $form = $(ev.target)

    showError = (errors) ->
      console.log errors
      alert 'Error banget'

    showLoading = (show) ->
      $form.find('input,button,textarea').prop('disabled', show)
      if show
        $form.find('.loader').show()
      else
        $form.find('.loader').hide()

    data = $form.serializeArray()
    showLoading(true)
    ev.preventDefault()
    $.ajax $form.attr('action'),
      data: data
      dataType: 'json'
      method: $form.attr('method')
      error: (xhr, status, err) ->
        console.log err
        alert(status)
        showLoading(false)
      success: (data, status, xhr) ->
        if data.link
          document.location = data.link
        else if data.errors
          showError data.errors
        else
          console.log data
          alert 'invalid return'
        showLoading(false)
