define (require) ->

  Marionette = require 'marionette'
  App        = require 'App'
  Home       = require 'pages/home/Home'

  class AppController extends Marionette.Controller

    home: -> if App.secured() then new Home()