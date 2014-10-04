Importer = require './importer'

importAll = (app, file) ->
  new Importer(app, file).importAll!

module.exports =
  importAll: importAll