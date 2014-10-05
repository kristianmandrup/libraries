config    = {}

Composite = require './composite'

class Directory
  (@app, @config) ->

  bowerDir: ->
    @app.bowerDirectory if @name is 'bower'

  dir: (@name) ->
    @config[@name] or @bowerDir! or @name

Reader = require './reader'

module.exports = class Importer implements Reader
  (@app, @options = {}) ->
    @file   = @options.file or './imports/libraries.json'
    @libs!
    @

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
