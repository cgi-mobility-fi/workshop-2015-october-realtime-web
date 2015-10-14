_            = require 'lodash'
Backbone     = require 'backbone'
request      = require 'request'
VehicleModel = require '../models/VehicleModel'

class Vehicles extends Backbone.Collection

  url: 'http://data.itsfactory.fi/siriaccess/vm/json'

  model: VehicleModel

  parse: (data) ->
    {VehicleActivity} = data.Siri.ServiceDelivery.VehicleMonitoringDelivery[0]

    _.map VehicleActivity, (activity) ->
      op = activity.MonitoredVehicleJourney.OperatorRef.value
      ln = activity.MonitoredVehicleJourney.LineRef.value
      id = activity.MonitoredVehicleJourney.VehicleRef.value || "#{op}_#{ln}"

      {
        id
        updated: activity.RecordedAtTime
        origin: activity.MonitoredVehicleJourney.OriginName.value
        destination: activity.MonitoredVehicleJourney.DestinationName.value
        location:
          longitude: activity.MonitoredVehicleJourney.VehicleLocation.Longitude
          latitude:  activity.MonitoredVehicleJourney.VehicleLocation.Latitude
      }

  sync: (method, collection, options) =>
    if method != 'read'
      console.error "Vehicles[] attempted to #{method}"
    else
      request @url, {json: true}, (error, response, body) ->
        if error
          options.error error
        else
          options.success body

vehicles = new Vehicles()
setInterval(
  -> vehicles.fetch {update: true, remove: true}
  2000
)

module.exports = vehicles