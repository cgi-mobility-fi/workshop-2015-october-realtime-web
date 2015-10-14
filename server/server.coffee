config =                                                                        # Configuration
  name:         'Innovation Day Demo'
  port:         3000
  pub:          '/public'
  cookieSecret: 'innovation'

http         = require 'http'                                                   # Require http
express      = require 'express'                                                # Require the Express Web server
SocketIO     = require 'socket.io'                                              # Require Socket.io
session      = require 'express-session'                                        # Require express-session
ConnectRedis = require 'connect-redis'                                          # Require connect-redis
CookieParser = require 'cookie-parser'                                          # Require cookie-parser
bodyParser   = require 'body-parser'                                            # Require body-parser (for HTTP POST)
morgan       = require 'morgan'                                                 # Require morgan - logging middleware
ApiRouter    = require './api/router'                                           # Require our API router

app          = express()                                                        # Create an Express App
server       = http.Server app                                                  # Get the Express App server instance
io           = SocketIO server                                                  # Init a socket using the same server
RedisStore   = ConnectRedis session                                             # Create a redis store middleware
cookieParser = CookieParser()                                                   # Create a cookie-parser middleware

if app.get 'env' != 'test'                                                      # If not running a mocha test...
  app.use morgan 'dev'                                                          # ... use morgan and log HTTP requests


sessionMiddleware = session                                                     # Create our session middleware...
  store:             new RedisStore()                                           #   Using redis as the session store
  secret:            config.cookieSecret                                        #   Secret for securing cookies
  cookie:            secure: false                                              #   Unsecure for HTTP servers
  saveUninitialized: true
  resave:            true

app.use cookieParser                                                            # Use Cookie Parser - needed for sess
app.use sessionMiddleware                                                       # Use sessions with our Web server
app.use bodyParser.json()                                                       # Use JSON body parser for PUT/POST

io.use (socket, next) ->                                                        # Make Socket.io use...
  sessionMiddleware socket.request, socket.request.res, next                    #         ...our session middleware

apiRouter = new ApiRouter app, io

server.listen config.port, ->                                                   # Start listening... HTTP + WebSockets
  console.log '%s listening at %s', config.name, server.address().port

module.exports = server                                                         # Exporting server for test runner