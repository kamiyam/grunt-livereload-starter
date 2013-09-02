"use strict"

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
            [lrSnippet, folderMount(connect, ".")]

    # Configuration to be run (and then tested)
    watch:
      options:
        nospawn: false
        livereload: true

      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: "*.html"

    # browser open
    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"
        app: 'Google Chrome Canary'
#        app: 'Google Chrome'

    coffee:
      grunt:
        files:
          ".Gruntfile.js": "Gruntfile.coffee"

  # modules load
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # task configure
  grunt.registerTask "default", ["coffee:grunt", "connect", "open", "watch"]