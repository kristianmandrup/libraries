FileIO        = require '../file-io'
Components    = require '../component/components'
Container     = require './container'
Containers    = require './containers'

module.exports = class Configurator implements FileIO
  (@options = {}) ->
    @file = @options.config-file or @config-file!
    @validate!
    @read!
    @config = @json!.config or {}
    @

  config-file: ->
    if @options.env then @env-file! else './xlibs/config.json'

  env-file: ->
    ['./xlibs', @options.env,  'config'].join '/'


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
