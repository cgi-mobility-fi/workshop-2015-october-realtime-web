define (require) ->
  Sockpuppet   = require 'sockpuppet'
  Backbone     = require 'backbone'
  VehicleModel = require 'models/VehicleModel'

  class Vehicles extends Backbone.Collection

    model: VehicleModel

    sync: Sockpuppet.sock.sync( 'siri' )