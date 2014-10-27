BaseLoader      = require './base-loader'
FileLoader      = require './local/file-loader'
JsonLoader      = require './local/json-loader'
CompositeLoader = require './local/composite-loader'
Normalizer      = require '../normalizer'

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

module.exports = class LocalLoader extends BaseLoader
  (@name, @options = {}) ->
    super ...
    @type       = @options.type or 'composite'
    @component  = @options.component or 'bower'
    @path       = @options.path or gconf.components!.dir!
    @validate!
    @

  validate: ->

  load-config: ->
    @normalize @loaded-config!

  has-config: (name) ->
    name ||= @name
    @loader!.has-config name

  normalize: (config) ->
    @normalizer config .normalize!

  normalizer: (config) ->
    new Normalizer config, @component

  loaded-config: ->
    @loader!.load-config!

  loader: ->
    clazz = @selected-loader!
    new clazz @name, @path, @options

  selected-loader: ->
    @loaders![@type] or @bad-loader!

  loaders: ->
    file: FileLoader
    json: JsonLoader
    composite: CompositeLoader

  bad-loader: ->
    throw new Error "unknown Loader #{@type}"