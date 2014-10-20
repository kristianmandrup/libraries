FileLoader      = require './local/file-loader'
JsonLoader      = require './local/json-loader'
CompositeLoader = require './local/composite-loader'

module.exports = class LocalLoader
  (@name, @options = {}) ->
    @loader     = @options.loader || 'composite'
    @component  = @options.component || 'bower'
    @path       = @options.path
    @validate!

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  load-config: ->
    @normalize @adapted!

  normalize: (config) ->
    @normalizer config .normalize!

  normalizer: (config) ->
    new Normalizer config, @component-type

  adapted: ->
    @adapter!.adapt!

  adapter: ->
    new @selected-loader! @name, @path, @options

  selected-loader: ->
    @loaders[@type] or @bad-loader!

  loaders: ->
    file: FileLoader
    json: JsonLoader
    composite: CompositeLoader

  bad-loader: ->
    throw new Error "unknown Installer #{@type}"