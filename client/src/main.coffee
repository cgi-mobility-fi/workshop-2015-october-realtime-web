require.config
  baseUrl: 'app'
  paths:
    'sockpuppet': '../libs/sockpuppet'

    'utils': '../utils'

    'jquery':       '../libs/jquery'
    'autocomplete': '../libs/jquery.autocomplete'
    'underscore':   '../libs/lodash'
    'backbone':     '../libs/backbone'
    'marionette':   '../libs/backbone.marionette'
    'socket.io':    '../libs/socket.io'
    'text':         '../libs/require.text'
    'tpl':          '../libs/require.underscore-tpl'
    'moment':       '../libs/moment'
    'leaflet':      '//cdn.leafletjs.com/leaflet-0.7.5/leaflet'

require(
  ['jquery', 'App', 'AppRouter', 'AppController'],
  ($, App, AppRouter, AppController) ->

    $.ajaxSetup
      contentType : 'application/json',
      crossDomain: true,
      xhrFields: {withCredentials: true}

    App.router = new AppRouter
      controller: new AppController App

    # Here you could check if the user is logged, before starting the app
    ###
    $.get App.api + '/login'

    .done ->
      App.user.set('loggedIn', true)

    .always ->
      App.start()
    ###

    # But for this demo, we just start the app
    App.start()
)