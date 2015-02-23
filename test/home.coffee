
casper.test.begin 'Home page', 2, (test) ->
  casper.start 'http://localhost:3000/', () ->
    test.assertTitle 'Obrolan Penting', 'title OK'
    test.assertExists 'form#testimoni-form', 'form exists'
    @fill 'form#testimoni-form', {testimoni: 'Hi'}, true
  
  casper.run -> test.done()
