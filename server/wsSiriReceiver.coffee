io = require 'socket.io-client'

serverUrl = 'http://127.0.0.1:3000'
client    = io.connect serverUrl

client.on 'siri', (update) ->
  console.log 'siri update', update

client.on 'connect', ->
  console.log 'connected'
  client.emit 'siri::read'

client.on 'error', (error) ->
  console.log error