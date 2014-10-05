app =
  import: (location, opts = '') ->
    x = if opts then '", ' else '"'
    console.log 'app.import(  "' + location + x, opts, ');',
  bowerDirectory: 'bower_components'

libraries = require '../libraries'
libraries.importAll app

file = './imports/libraries.json'

libraries.importAll app, file: file

console.log 'with options'

libraries.importAll app, file: './imports/libraries.json', config: {vendor: 'vendor/dev'}

Adder = require '../adder'
adder = new Adder file: file

adder.addLibs 'bower', 'dist/ember-validations.js'
adder.addLibs 'vendor', ['v.js', 'z.js']
adder.addLibs bower: 'blip/blap.js'

adder.addRemaps 'bower', {'jquery/core': 'dist/core/jquery.js'}

# libraries.adder.addLibs 'chaines', ['sdfds/sddsg.js']

# adder.save file + '.bak'
# adder.print console.log

console.log 'libs', adder.libs

