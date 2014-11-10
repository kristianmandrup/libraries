LocalAdapter   = require './adapter/local-adapter'
RemoteAdapter  = require './adapter/remote-adapter'

GlobalConfig  = require '../global-config'
gconf         = new GlobalConfig

module.exports = class Registry
  (@options = {}) ->
    @type ||= @options.type or @default-type!
    @validate!
    @

  default-type: ->
    gconf.get 'registry.adapter.from' or 'local'

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  install: (name) ->
    @adapter!.install name

  adapter: ->
    clazz = @selected-adapter!
    new clazz @options

  selected-adapter: ->
    @adapters[@type] or @bad-adapter!

  adapters:
    local:   LocalAdapter
    remote:  RemoteAdapter

  bad-adapter: ->
    @error "Registry adapter #{@type} has not been registered"

  error: (msg)->
    throw new Error




