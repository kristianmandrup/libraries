# will try to load from local cache. If not found in cache, will install from remote,
# then load installed config from cache

RemoteLoader      = require './config/loader/remote-loader'
LocalLoader       = require './config/loader/local-loader'
BaseLoader        = require './config/loader/base-loader'

module.exports = class CompositeLoader extends BaseLoader
  (@name, @options = {}) ->
    super ...
    @loader     = @options.loader || 'composite'
    @component  = @options.component || 'bower'
    @path       = @options.path
    @validate!
    @

  validate: ->

  local: ->
    @_local ||= new LocalLoader @name, @options

  # will install from remote, then load installed config from cache
  remote: ->
    @_remote ||= new RemoteLoader @name, @options

  # If not found in local cache, will install from remote into local cache
  # Will load installed config from cache
  load-config: ->
    unless @local!.has-config @name
      @remote!.install!
    @local!.load-config!