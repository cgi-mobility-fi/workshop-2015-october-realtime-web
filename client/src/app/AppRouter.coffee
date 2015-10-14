define (require) ->

  Marionette = require 'marionette'

  class AppRouter extends Marionette.AppRouter

    appRoutes: {
      '': 'home'
    }