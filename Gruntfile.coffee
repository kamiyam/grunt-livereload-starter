"use strict"

# Listen on port 35729
LIVERELOAD_PORT = 35729

lrSnippet = require('connect-livereload')( port: LIVERELOAD_PORT )
folderMount = (connect, base) ->
  console.log(base)
  # Serve static files.
  connect.static ( require("path").resolve base )

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    connect:
      options:
        port: 9000
        hostname: "localhost"
      livereload:
        options:
          middleware: (connect, options) ->
            [lrSnippet, folderMount(connect, "public")]

    # Configuration to be run (and then tested)
    watch:
      options:
        livereload: true

      coffee:
        options:
          livereload: false
        files: ["public/coffee/**/*.coffee"]
        tasks: ["coffee:coffees"]

      livereload:
        options:
          cwd: "./public"
          livereload: LIVERELOAD_PORT
        files: ["**/*.html","css/**/*.css","js/**/*.js"]

    # browser open
    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"
        app: 'Google Chrome Canary'
#        app: 'Google Chrome'
#        file:
#      file:
#        path: '/etc/hosts'
#        app: 'Sublime Text'

    coffee:
      grunt:
        files:
          ".Gruntfile.js": "Gruntfile.coffee"
      coffees:
        options:
          bare: true
        expand: true
        flatten: true
        src: ['public/coffee/**/*.coffee']
        dest: 'public/js/'
        ext: '.js'


  # modules load
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # task configure
  grunt.registerTask "default", ["coffee", "connect", "open", "watch"]