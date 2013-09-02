"use strict"

path = require("path")
lrSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
folderMount = (connect, base) ->
  console.log(base)
  # Serve static files.
  connect.static ( path.resolve base )

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
    regarde:
      fred:
        files: "*.html"
        tasks: ["livereload"]

    # browser open
    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    coffee:
      grunt:
        files:
          ".Gruntfile.js": "Gruntfile.coffee"

  # modules load
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # task configure
  grunt.registerTask "default", ["coffee:grunt", "livereload-start", "connect", "open", "regarde"]