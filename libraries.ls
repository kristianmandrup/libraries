Importer = require './importer'

importAll = (app, options = {}) ->
  new Importer(app, options).importAll!

module.exports =
  importAll: importAll