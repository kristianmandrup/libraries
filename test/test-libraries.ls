app =
  import: (location) ->
    console.log 'app.import("' + location + '");'
  bowerDirectory: 'bower_components'

libraries = require './libraries'
libraries.importAll app
