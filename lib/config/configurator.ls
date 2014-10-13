FileIO        = require '../file-io'
Components    = require '../component/components'
Container     = require './container'
Containers    = require './containers'

module.exports = class Configurator implements FileIO
  (@options = {}) ->
    @file = @options.file or './xlibs/config.json'
    @validate!
    @read!
    @config = @json!.config or {}
    @

  validate: ->
    unless @exists!
      throw new Error "File #{@file} does not exist"

  install: ->
    @containers!.install!

  build: (cb) ->
    cb ||= @options.cb
    @install!
    @containers!.build cb

  containers: ->
    @_containers ||= new Containers @container-objs!, @config

  container-objs: ->
    @_container-objs ||= @json!.containers
