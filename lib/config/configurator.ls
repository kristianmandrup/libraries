FileIO      = require '../file-io'
Components  = require '../component/components'
Container   = require './container'

module.exports = class Configurator implements FileIO
  (@file) ->
    @file ||= './xlibs/config.json'
    @validate!
    @read!
    @config = @json!.config or {}
    @

  install: ->
    @components.install!

  components: ->
    @_components ||= new Components @

  validate: ->
    unless @exists!
      throw new Error "File #{@file} does not exist"
    unless typeof! @containers! is 'Object'
      throw new Error "Must have 'containers' Object"

  containers: ->
    @_containers ||= @json!.containers

  # f.ex bower or vendor
  # TODO: cache?
  container: (name) ->
    new Container(@containers![name] or {}, @config)
