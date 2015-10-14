getTest  = require './rest/getTest'
postTest = require './rest/postTest'
ping     = require './ws/ping'
rng      = require './ws/rng'
siri     = require './ws/siri'

class Router

  socketOnConnect: [
    rng
  ]

  socketEvents:
    'ping':       ping
    'siri::read': siri

  routes:
    'get /test':  getTest
    'post /test': postTest

  constructor: (app, io) ->
    @app = app
    @io  = io

    @initRestServices app
    @initSocketServices io

  initRestServices: (app) ->
    for route, handler of @routes
      [method, path] = route.split ' '

      app[method] path, handler

  initSocketServices: (io) =>

    @io.on 'connection', (socket) =>
      for handler in @socketOnConnect
        handler socket

      for event, handler of @socketEvents
        socket.on event, (data, callback)->
          handler socket, data, callback

module.exports = Router