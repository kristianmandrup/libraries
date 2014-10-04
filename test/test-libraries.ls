app =
  import: (location, opts = '') ->
    x = if opts then '", ' else '"'
    console.log 'app.import(  "' + location + x, opts, ');',
  bowerDirectory: 'bower_components'

libraries = require '../libraries'
libraries.importAll app

libraries.importAll app, file: './imports/libraries.json'

console.log 'with options'

libraries.importAll app, file: './imports/libraries.json', config: {vendor: 'vendor/dev'}
