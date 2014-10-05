Importer   = require './importer'
Adder      = require './adder'
Remover    = require './remover'

module.exports = class Libraries
  (@app, @options) ->
    @importer!
    @

  importer: ->
    @importer = new Importer(@app, @options)

  importAll: ->
    @importer.importAll!

  addLibs: (...args) ->
    @importer.addLibs ...args

  removeLibs: (...args) ->
    @importer.removeLibs ...args

  addLib: (...args) ->
    @importer.addLib ...args

  removeLib: (...args) ->
    @importer.removeLib ...args

  addRemaps: (...args) ->
    @importer.addRemaps ...args

  removeRemaps: (...args) ->
    @importer.removeRemaps ...args

  addRemap: (...args) ->
    @importer.addRemap ...args

  removeRemap: (...args) ->
    @importer.removeRemap ...args

  print: (...args) ->
    @importer.print ...args

  save: (...args) ->
    @importer.save ...args

  load: (...args) ->
    @importer.load ...args