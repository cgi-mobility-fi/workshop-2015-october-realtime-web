process.env.NODE_ENV = 'test'

assert  = require 'assert'
request = require 'supertest'
server  = require '../server'

describe 'Demo Server', ->
  describe 'REST API', ->
    describe 'GET /', ->
      it 'should respond with 404 ', (done) ->
        request server
        .get '/'
        .expect 404, done

    describe 'GET /test', ->
      it 'should respond with HTTP code 200', (done) ->
        request server
        .get '/test'
        .expect 200, done

      it 'should respond with JSON', (done) ->
        request server
        .get '/test'
        .expect 'Content-Type', /json/, done

      it 'should respond with { message: "hello world" }', (done) ->
        request server
        .get '/test'
        .expect {message: 'hello world'}, done

    describe 'POST /test <- {message: "ping" }', ->
      it 'should respond with HTTP code 200', (done) ->
        request server
        .post '/test'
        .send {message: 'ping'}
        .expect 200, done

      it 'should respond with JSON', (done) ->
        request server
        .post '/test'
        .send {message: 'ping'}
        .expect 'Content-Type', /json/, done

      it 'should respond with { message: "pong" }', (done) ->
        request server
        .post '/test'
        .send {message: 'ping'}
        .expect {message: 'pong'}, done