

$(document).ready ->
  ws = new WebSocket('ws://127.0.0.1:8080/websocket')

  ws.onopen = (evt) ->
    $('#messages').append('<li>WebSocket connection opened.</li>')


  ws.onmessage = (evt) ->
    $('#messages').append('<li>' + evt.data + '</li>')


  ws.onclose = (evt) ->
    $('#messages').append('<li>WebSocket connection closed.</li>');


  $('#send').submit ->
    ws.send($('input:first').val())
    $('input:first').val('').focus()
    $('#audio-welcome')[0].play()
    return false
