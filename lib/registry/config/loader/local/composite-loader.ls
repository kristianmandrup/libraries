BaseLoader    = require '../base-loader'
FileLoader    = require './file-loader'
JsonLoader    = require './json-loader'

module.exports = class CompositeConfigLoader extends BaseLoader
  (@name, @path, @options = {}) ->
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

  has-config: (name) ->
    name ||= @name
    for loader in @loaders!
      return true if loader.has-config name
    false

  load-config: (name) ->
    for loader in @loaders!
      conf = loader.load-config name
      return conf if conf

  loaders: ->
    [@file-loader!, @json-loader!]

  file-loader: ->
    @_file-loader ||= new FileLoader @name, @path, @options

  json-loader: ->
    @_json-loader ||= new JsonLoader @name, @path, @options