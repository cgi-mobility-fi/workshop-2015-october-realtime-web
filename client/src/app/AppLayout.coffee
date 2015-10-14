define (require) ->

  Marionette = require 'marionette'

  class AppLayout extends Marionette.LayoutView

    el: 'body'

    template: false

    regions: {'header', 'main', 'footer'}