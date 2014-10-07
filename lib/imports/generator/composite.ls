RemapImporter = require './remap-importer'
LibImporter   = require './lib-importer'

module.exports = class Composite
  (@app, @directory) ->

  importAll: (values) ->
    new LibImporter(@, values.libs).importAll! if values.libs
    new RemapImporter(@, values.remap).importAll! if values.remap
