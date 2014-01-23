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
      dev:
        options:
          middleware: (connect, options) ->
            [
              lrSnippet
              folderMount(connect, ".tmp/public")
              folderMount(connect, "public")
            ]

      dist:
        options:
          middleware: (connect, options) ->
            [
              lrSnippet
              folderMount(connect, "dist")
            ]

  #Set compile settings
    sass:
      dev:
        files: [
          expand: true
          cwd: "public/css/"
          src: ["**/*.sass","**/*.scss"]
          dest: ".tmp/public/css/"
          ext: ".css"
        ]

    less:
      dev:
        files: [
          expand: true
          cwd: "public/css/"
          src: ["**/*.less"]
          dest: ".tmp/public/css/"
          ext: ".css"
        ]

    stylus:
      dev:
        files: [
          expand: true
          cwd: "public/css/"
          src: ["**/*.styl"]
          dest: ".tmp/public/css/"
          ext: ".css"
        ]

    coffee:
      grunt:
        files:
          ".Gruntfile.js": "Gruntfile.coffee"

      dev:
        files: [
          options:
            bare: true
          expand: true
          cwd: "public/js/"
          src: ['**/*.coffee']
          dest: ".tmp/public/js/"
          ext: '.js'
        ]

    typescript:
      dev:
        files: [
          expand: true
          cwd: "public/js/"
          src: ['**/*.ts']
          dest: ".tmp/public/js/"
          ext: '.js'
        ]

  # watch files settings
    watch:
      options:
        livereload: false

      sass:
        options:
          cwd: "public/css"
        files: ["**/*.sass", "**/*.scss"]
        tasks: ["sass:dev"]

      less:
        options:
          cwd: "public/css"
        files: ["**/*.less"]
        tasks: ["less:dev"]

      stylus:
        options:
          cwd: "public/css"
        files: ["**/*.styl"]
        tasks: ["stylus:dev"]

      coffee:
        options:
          cwd: "public/js"
        files: ["**/*.coffee"]
        tasks: ["coffee:dev"]

      typescript:
        options:
          cwd: "public/js"
        files: ["**/*.ts"]
        tasks: ["typescript:dev"]

      plain:
        options:
          cwd: "public"
          livereload: LIVERELOAD_PORT
        files: ["**/*.html", "css/**/*.css", "js/**/*.js"]

      compiled:
        options:
          cwd: ".tmp/public"
          livereload: LIVERELOAD_PORT
        files: ["**/*.html", "css/**/*.css", "js/**/*.js"]

    clean:
      grunt:
        src: ".Gruntfile.js"
      dev:
        src: [".tmp/**"]
      dist:
        src: ["dist/**"]

    copy:
      dist:
        files:[
          {
            expand: true
            cwd: 'public/'
            src: ["**","!**/*.{coffee,ts,sass,scss,less,styl}"]
            dest: "dist/"
          },
          {
            expand: true,
            cwd: ".tmp/public/"
            src: ["**"],
            dest: "dist/"
          }
        ]

  # browser open
    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"
#        app: 'Google Chrome Canary'

  # modules load
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # task configure
  grunt.registerTask "default", ["clean", "coffee:grunt", "compile", "connect:dev", "open", "watch"]

  grunt.registerTask "deploy", ["clean", "compile", "copy:dist"]

  grunt.registerTask "dist", ["deploy", "connect:dist", "open", "watch"]

  grunt.registerTask "compile", ["coffee:dev","typescript:dev", "sass:dev", "less:dev", "stylus:dev"]

