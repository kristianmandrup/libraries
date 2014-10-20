BaseLoader  = require './base-loader'
Registry    = require '../../registry'

module.exports = class RemoteConfigLoader extends BaseLoader
  (@name, registry) ->
    super ...
    @_registry = registry if registry

  config-file: (name) ->
    name ||= @name
    @registry!.read-config name

  has-config: (name) ->
    name ||= @name
    @registry!.has name

  registry: ->
    @_registry ||= new Registry 'uri'

