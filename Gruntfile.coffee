fs = require 'fs'

DEBUG = true
ZEPTO_MODULES = ['zepto', 'event', 'ajax', 'form', 'fx', 'fx_methods', 'selector', 'touch']


module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    
    stylus:
      main: 
        options: 
          paths: ['bower_components/bootstrap-stylus']
          urlfunc: 'embedurl' # use embedurl('test.png') in our code to trigger Data URI embedding
          sourcemap: DEBUG
        files: 
          'public/css/style.css': 'assets/stylesheets/style.styl' # 1:1 compile

    coffee:
      options:
        bare: true
        sourceMap: DEBUG
        join: true

      app:
        src: 'assets/scripts/*.coffee'
        dest: 'build/app.js'

    uglify:
      options:
        banner: ''
        sourceMap: DEBUG

      app:
        options:
          sourceMapIn: 'build/app.js.map'
        src: 'build/app.js'
        dest: 'public/js/app.js'

    copy:
      img:
        expand: true
        cwd: 'assets/img/'
        src: ['*.jpg', '*.png', '**']
        dest: 'public/img/'

    watch:
      js:
        files: 'assets/scripts/*.coffee'
        tasks: ['coffee', 'uglify:app']
      css:
        files: 'assets/stylesheets/*.styl'
        tasks: ['stylus']
        options: 
          debounceDelay: 250
      express:
        options:
          livereload: true
          spawn: false
        files: ['app/controllers/**', 'app/models/**']
        tasks: ['express:dev']

    express:
      dev: 
        options: 
          script: 'server.js'
      prod: 
        options: 
          script: 'server.js',
          node_env: 'production'

    casperjs:
      options:
        casperjsOptions: '--xunit=test.log.xml'
      files: ['test/']



  grunt.loadNpmTasks 'grunt-contrib-stylus'
  #grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  #grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-casperjs'
  #grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'build', ['copy', 'stylus', 'coffee', 'uglify']
  grunt.registerTask 'server', ['build', 'express:dev', 'watch']
  grunt.registerTask 'test', ['build', 'express:dev', 'casperjs']
  
  
  
