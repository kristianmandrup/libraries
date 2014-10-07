app =
  import: (location, opts = '') ->
    x = if opts then '", ' else '"'
    console.log 'app.import(  "' + location + x, opts, ');'

  bowerDirectory: 'bower_components'

Libraries = require '../libraries'
libraries = new Libraries app: app

orig-file = './xlibs/_libraries.json'
file = './xlibs/libraries.json'

fs = require 'fs'

# copy original file
copy-file = (source, target) ->
  fs.writeFileSync target, fs.readFileSync(source)

copy-file orig-file, file

libraries.importAll app, file: file

console.log 'with options'

libraries.importAll app, file: file, config: {vendor: 'vendor/dev'}


libraries.addLibs 'bower', 'dist/ember-validations.js'
libraries.addLibs 'vendor', ['v.js', 'z.js']
libraries.addLibs bower: 'blip/blap.js'

libraries.addRemaps 'bower', {'jquery/core': 'dist/core/jquery.js', 'famous/core': 'famous/dist/core/famous.js'}

# libraries.adder.addLibs 'chaines', ['sdfds/sddsg.js']

libraries.removeLib 'bower', 'dist/ember-validations.js'
libraries.removeRemaps 'bower', 'jquery/core'
libraries.print!
