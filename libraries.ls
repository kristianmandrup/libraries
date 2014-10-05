Importer = require './importer'
Adder    = require './adder'

importAll = (app, options = {}) ->
  new Importer(app, options).importAll!

module.exports =
  importAll: importAll
  adder: new Adder