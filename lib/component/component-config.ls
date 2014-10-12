FileIO        = require '../file-io'
Registry      = require '../registry/registry'
ConfigLoader  = require '../registry/config-loader'
fs            = require 'fs'
util          = require 'util'

module.exports = class ComponentConfig implements FileIO
  (@name, @path) ->
    @path ||= './xlibs/components'
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"

    unless typeof! @path is 'String'
      throw new Error "Name of path to load from must be a String, was: #{@path}"

  load-it: ->
    @valid-config @config-loader!.load-config!

  build: ->
    throw new Error "Can't build this :P"

  install: (options = {}) ->
    if @should-install options
      @registry!.install @name

  should-install: (options = {}) ->
    options.force or @not-local!

  valid-config: (config) ->
    return config if typeof! config is 'Object'
    throw new Error "Invalid config for component #{@name}, was: #{util.inspect config}"

  registry: ->
    @_registry ||= new Registry

  config-loader: ->
    @_config-loader ||= new ConfigLoader @name, @path


