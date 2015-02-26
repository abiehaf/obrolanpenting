
casper.test.begin 'Home page', 2, (test) ->
  casper.start 'http://localhost:3000/', () ->
    test.assertTitle 'Obrolan Penting', 'Home page title'
    test.assertExists 'form#testimony-form', 'form exists'
    @fill 'form#testimony-form', {testimony: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'}, false
    @mouse.click '#testimony-form .btn'
    # todo: do it !!!

  casper.run -> test.done()
