module.exports = (socket) ->
  emitter         = -> socket.emit 'rng', Math.random()
  emitterInterval = setInterval emitter, 100

  socket.on 'disconnect', -> clearInterval emitterInterval