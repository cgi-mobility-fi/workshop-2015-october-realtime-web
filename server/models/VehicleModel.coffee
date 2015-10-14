Backbone = require 'backbone'

class VehicleModel extends Backbone.Model

  defaults:
    id:          null # String
    updated:     null # Timestamp
    origin:      null # String
    destination: null # String
    location:    null # Object { logitude, latitude }

module.exports = VehicleModel