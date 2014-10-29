LocalBowerAdapter         = require './package/bower/local-bower'
RemoteBowerAdapter        = require './package/bower/remote-bower'

RemoteComponentAdapter    = require './package/component/remote-component'
LocalComponentAdapter     = require './package/component/local-component'

module.exports = class PkgAdapter
  (@options = {}) ->
    @type = @options.type or 'bower'
    @from = @options.from or 'local'
    @name = options.name
    @validate!
    @

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

    unless typeof! @from is 'String'
      throw new Error "From must be a String, was: #{@from}"

  adapt: (name) ->
    name ||= @name
    @adapter!.adapt!

  adapter: (name)->
    name ||= @name
    clazz = @adapter-clazz!
    new clazz name

  adapter-clazz: ->
    @adapters[@from][@type] or @bad-adapter!

  bad-adapter: ->
    @error "Adapter #{@from} for #{@type} has not been registered"

  error: (msg) ->
    console.error msg

  adapters:
    local:
      bower:      LocalBowerAdapter
      component:  LocalComponentAdapter
    remote:
      bower:      RemoteBowerAdapter
      component:  RemoteComponentAdapter