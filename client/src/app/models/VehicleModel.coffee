define (require) ->
  Backbone = require 'backbone'
  Leaflet  = require 'leaflet'

  class VehicleModel extends Backbone.Model

#    events:
#      'change:location':'onChangeLocation'

    defaults:
      id:          null # String
      updated:     null # Timestamp
      origin:      null # String
      destination: null # String
      location:    null # Object { longitude, latitude }

    initialize: ->
      location = @get('location')
      @marker = L.marker([location.latitude, location.longitude])

#    onChangeLocation: ->
#      location = @get('location')
#      @marker.setLatLng([location.longitude, location.latitude])