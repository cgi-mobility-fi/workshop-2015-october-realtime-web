module.exports = (req, res) ->
  if req.body.message == 'ping'
    res.send { message: 'pong' }
  else
    res.send 400