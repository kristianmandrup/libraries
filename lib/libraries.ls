Selector      = require './select/selector'
Configurator  = require './config/configurator'
Registry      = require './registry/registry'
Generator     = require './output/generator'

module.exports =
  select:   new Selector
  config:   new Configurator
  registry: new Registry

  install: ->
    select.install!

  build: ->
    console.log 'building...', @config
    for lib in @select.list!
      @config

