FileIO        = require '../util/file-io'
Components    = require '../component/components'
Container     = require './container'
Containers    = require './containers'

GlobalConfig = require '../../../../global-config'
gconf       = new GlobalConfig

module.exports = class Configurator implements FileIO
  (@options = {}) ->
    @file = @options.config-file or @config-file!
    @validate!
    @read!
    @config = @json!.config or {}
    @

  config-file: ->
    if @options.env then @env-file! else gconf.config.file

  env-file: ->
    [gconf.dir, @options.env,  'config.json'].join '/'


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
