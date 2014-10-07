app =
  import: (location, opts = '') ->
    x = if opts then '", ' else '"'
    console.log 'app.import(  "' + location + x, opts, ');'

  bowerDirectory: 'bower_components'

Importer = require '../component-importer'

fs = require 'fs'
comp-file = './xlibs/component.json'

readLibs = (file) ->
  fs.readFileSync file,'utf8'

components = JSON.parse readLibs(comp-file)

obj =
  app: app
  directory: app.bowerDirectory

importer = new Importer obj, components
importer.importAll!



