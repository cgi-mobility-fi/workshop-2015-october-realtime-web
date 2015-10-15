define (require) ->

  _          = require 'underscore'
  Sockpuppet = require 'sockpuppet'
  template   = require 'tpl!pages/home/Home.tpl'
  Leaflet    = require 'leaflet'
  Vehicles   = require 'collections/Vehicles'

  class Home extends Sockpuppet.Page

    template: template
    
    collection: new Vehicles()

    initialize: ->
      @listenTo @collection, 'add', @addMarkers
#      @listenTo vehicles, 'remove', @render
#      @listenTo vehicles, 'update', @render
      @collection.fetch()

    onRender: => _.defer =>
      @map = L.map(@$el.get(0)).setView([61.5, 23.766667], 13)

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png').addTo(@map)
      
    addMarkers: =>
      @collection.each (model) =>
        model.marker.addTo(@map)
