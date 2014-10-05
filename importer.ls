config    = {}

Composite = require './composite'

class Directory
  (@app, @config) ->

  validate: ->
    unless typeof @app is 'Object'
      throw new Error "Directory must take an app Object"

  bowerDir: ->
    @app.bowerDirectory if @name is 'bower'

  dir: (@name) ->
    @config[@name] or @bowerDir! or @name


Adder     = require './adder'
Remover   = require './remover'

module.exports = class Importer implements Adder, Remover
  (@app, @options = {}) ->
    @validate!
    @file   = @options.file or './imports/libraries.json'
    @libs!
    @

  validate: ->
    unless typeof @app is 'Object'
      throw new Error "Importer must take an app Object as first arg"

  init: (key) ->
    @libs[key] ||= {}

  dir: (name) ->
    @directory!.dir name

  directory: ->
    @_directory ||= new Directory @app, @config

  importAll: ->
    @config = @options.config or @libs['config'] or {}
    delete @libs['config']

    for key, value of @libs
      @importFor key, value

  importFor: (name, values) ->
    new Composite(@app, @dir(name)).importAll values
