# will try to load from local cache. If not found in cache, will install from remote,
# then load installed config from cache

Registry   = require './registry'

module.exports = class CompositeRegistry
  (@options-list = []) ->
    @validate!
    @

  validate: ->

  registries: []

  configure: ->
    for options in @options-list
      @registries.push @registry options

  registry: (options) ->
    new Registry options
