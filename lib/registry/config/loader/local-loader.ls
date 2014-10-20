BaseLoader      = require './base-loader'
FileLoader      = require './local/file-loader'
JsonLoader      = require './local/json-loader'
CompositeLoader = require './local/composite-loader'
Normalizer      = require '../normalizer'

module.exports = class LocalLoader extends BaseLoader
  (@name, @options = {}) ->
    super ...
    @loader     = @options.loader or 'composite'
    @component  = @options.component or 'bower'
    @path       = @options.path
    @validate!
    @

  validate: ->

  load-config: ->
    @normalize @adapted!

  has-config: (name) ->
    name ||= @name
    @adapted!.has-config name

  normalize: (config) ->
    @normalizer config .normalize!

  normalizer: (config) ->
    new Normalizer config, @component

  adapted: ->
    @adapter!.adapt!

  adapter: ->
    new @selected-loader! @name, @path, @options

  selected-loader: ->
    @loaders![@loader] or @bad-loader!

  loaders: ->
    file: FileLoader
    json: JsonLoader
    composite: CompositeLoader

  bad-loader: ->
    throw new Error "unknown Loader #{@loader}"