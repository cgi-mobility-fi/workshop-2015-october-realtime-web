vehicles = require '../../collections/vehicles'

module.exports = (socket) ->
  socket.emit 'siri', vehicles.toJSON()

  update = (item) -> socket.emit 'siri', [item.toJSON()]

  vehicles.on 'add',    update, socket
  vehicles.on 'change', update, socket

  socket.on 'disconnect', ->
    vehicles.off 'add',    update, socket
    vehicles.off 'change', update, socket
