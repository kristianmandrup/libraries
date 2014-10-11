FileIO      = require '../file-io'
Components  = require '../component/components'
Container   = require './container'

module.exports = class Configurator implements FileIO
  (@options = {}) ->
    @file = @options.file or './xlibs/config.json'
    @validate!
    @read!
    @config = @json!.config or {}
    @

  install: ->
    @components.install!

  build: (cb) ->
    cb ||= @options.cb
    @containers.build cb

  components: ->
    @_components ||= new Components @

  containers: ->
    @_containers ||= new Containers @container-objs!, @config

  validate: ->
    unless @exists!
      throw new Error "File #{@file} does not exist"
    unless typeof! @containers! is 'Object'
      throw new Error "Must have 'containers' Object"

  container-objs: ->
    @_container-objs ||= @json!.containers
