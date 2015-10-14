process.env.NODE_ENV = 'test'

_       = require 'lodash'
assert  = require 'assert'
request = require 'supertest'
server  = require '../server'
io      = require 'socket.io-client'

# Needed for WebSocket tests
{port}    = server.address()
serverUrl = "http://127.0.0.1:#{port}"

describe 'Demo Server', ->
  client  = null

  before (done) ->
    client = io.connect serverUrl

    client.on 'connect', done
    client.on 'error', done

  after ->
    client.disconnect()

  describe 'WebSocket API', ->
    describe 'Random Number Generator', ->
      numbers = []

      it 'should send data at least 5 times', (done) ->
        client.on 'rng', (data) ->
          numbers.push data

          if numbers.length >= 5
            client.off 'rng'
            done()

      it 'should send numeric data', ->
        for n in numbers
          assert.equal typeof n, 'number'

      it 'should send values which are unique', ->
        assert.ok numbers.length > 0
        assert.equal numbers.length, _.uniq(numbers).length

    describe 'acknowledge callback (request-response)', ->
      it 'should respond to "ping" with "pong"', (done) ->
        client.emit 'ping', null, (response) ->
          assert.equal response, 'pong'
          done()