fs        = require 'fs'
config    = {}

Composite = require './composite'

module.exports = class Importer
  (@app, @file = './imports/libraries.json') ->
    @libs!
    @

  readLibs: ->
    fs.readFileSync @file,'utf8'

  libs: ->
    # console.log @readLibs!
    @libs = JSON.parse @readLibs!

  importAll: ->
    @config = @libs['config'] or {}
    delete @libs['config']

    for key, value of @libs
      @importFor key, value

  importFor: (name, values) ->
    directory = @config[name] or name
    directory = @app.bowerDirectory if name is 'bower'
    new Composite(@app, directory).importAll values
