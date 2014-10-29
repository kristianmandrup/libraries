UriAdapter  = require './remote/uri-adapter'

module.exports = class RemoteRegistryAdapter
  (@options = {}) ->
    @type ||= @options.type or 'bower'
    @installer-type = @options.installer or 'json'
    @adapter-type = @options.adapter or 'pkg'
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @type is 'String'
      throw Error "Type must be a String, was: #{@type}"

    unless typeof! @adapter-type is 'String'
      throw Error "adapter type must be a String, was: #{@adapter-type}"

  load: ->
    @adapter!.load!

  install: ->
    @adapter!.install @installer-type

  adapter: ->
    clazz = @selected-adapter!
    new clazz @options

  selected-adapter: ->
    @adapter[@adapter-type] or @bad-adapter!

  adapters:
    uri:  UriAdapter

  bad-adapter: ->
    throw new Error "unknown adapter #{@adapter-type}"