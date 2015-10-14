define (require) ->

  _          = require 'underscore'
  Sockpuppet = require 'sockpuppet'
  template   = require 'tpl!pages/home/Home.tpl'
  Leaflet    = require 'leaflet'

  class Home extends Sockpuppet.Page

    template: template

    onRender: => _.defer =>
      map = L.map(@$el.get(0)).setView([61.5, 23.766667], 13)

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png').addTo(map)

      L.marker([61.4947775, 23.5694143]).addTo(map).bindPopup('ABC_123')