define (require) ->

  $          = require 'jquery'
  Backbone   = require 'backbone'
  Marionette = require 'marionette'
  AppLayout  = require 'AppLayout'
  Sockpuppet = require 'sockpuppet'

  App        = new Marionette.Application()
  App.layout = new AppLayout()

  App.api = 'http://localhost:3000' # Ideally this should come from a conf file

  App.navigate = (path, options = { trigger: true }) ->
    App.router.navigate path, options

  App.secured = ->
    # Check here if the user is logged in
    # For example...
    ###
    if !App.user.get 'loggedIn'
      console.log 'AppController.isSecured: The user is not logged in'
      App.navigate 'login', {trigger: true, replace: true}
      false
    else
      true
    ###

    # But for this demo, let's say we're always logged in:
    true

  App.addInitializer ->
    console.log 'App is starting'
    Backbone.history.start()

  App.layout.render()

  Sockpuppet.setApplication(App)

  App