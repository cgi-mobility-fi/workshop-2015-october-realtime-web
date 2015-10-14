autoprefixer = require 'autoprefixer'
stylish      = require 'jshint-stylish'
path         = require 'path'

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    stylus:
      compile:
        options:
          compress: false

        import: [__dirname + "src/style/color-scheme.styl"]
        files:
          "build/style.css": ["src/style/main.styl"]

    copy:
      build:
        expand: true
        cwd: "src"
        dest: "build/"
        src: [
          "**"
          "!style/**/*.styl"
        ]

      release:
        expand: true
        cwd: "build"
        dest: "release"
        src: [
          "index.html"
          "style.css"
          "images/**"
          "libs/require.js"
          "libs/**/*.css"
          "libs/**/*.css.map"
          "libs/**/*.css.map"
        ]

    coffee:
      compile:
        options:
          sourceMap: true

        expand: true
        flatten: false
        cwd: "build"
        src: ["**/*.coffee"]
        dest: "build"
        ext: ".js"

    requirejs:
      options:
        banner:
          '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'

      compile:
        options:
          baseUrl: "build/app"
          include: ["../libs/require.js"]
          mainConfigFile: "build/main.js"
          name: "../main"
          out: "release/main.js"
          findNestedDependencies: true
          optimize: "uglify"

    jshint:
      all: [
        'Gruntfile.js'
        'src/app/**/*.js'
      ]
      options:
        reporter: stylish

    clean:
      build: [
        "build"
      ]
      
      release: [
        "release"
        "build-app"
        "release-app"
      ]

    express:
      options:
        hostname: '*'
        port: 8080

      livereload:
        options:
          bases: path.resolve('./build')
          livereload: true

    watch:
      all:
        files: ['./src/**']
        tasks: ['build']

    postcss:
      options:
        map: true
        processors: [
          autoprefixer
            browsers: ['last 2 versions']
        ]
      build:
        src: 'build/style.css'


  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-rename'
  grunt.loadNpmTasks 'grunt-postcss'


  grunt.registerTask 'dev',
    [
      'build'
      'express:livereload'
      'watch'
    ]

  grunt.registerTask 'build',
    [
      'clean'
      'jshint'
      'stylus'
      'postcss:build'
      'copy:build'
      'coffee'
    ]

  grunt.registerTask 'release',
    [
      'build'
      'requirejs'
      'copy:release'
    ]

  grunt.registerTask 'default',
    [
      'build'
    ]