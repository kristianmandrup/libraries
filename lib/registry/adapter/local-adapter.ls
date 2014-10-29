FileAdapter = require './local/file-adapter'
PkgAdapter  = require './local/pkg-adapter'

# TODO: use global config
module.exports = class LocalRegistryAdapter
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
    file: FileAdapter
    pkg:  PkgAdapter

  bad-adapter: ->
    throw new Error "unknown adapter #{@adapter-type}"