Selector      = require './select/selector'
Configurator  = require './config/configurator'

module.exports =
  select: new Selector
  config: new Configurator
  build: ->
    console.log 'building...', @config
    for lib in @select.list!
      @config

