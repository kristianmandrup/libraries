/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:30
 */
BaseConfigLoader  = require './base'
Registry          = require '../registry'

module.exports = class RemoteConfigLoader extends BaseConfigLoader
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

