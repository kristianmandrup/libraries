FileIO = require './file-io'

Adder =
  # add one or more libs to libraries file
  # call examples
  #   .addLibs 'bower', 'dist/ember-validations.js'
  #   .addLibs 'bower', ['dist/ember-validations.js', 'dist/ember-forms.js']
  #   .addLibs bower: 'dist/ember-validations.js', vendor: ['dist/xyz.js']
  addLibs: (key, names) ->
    if typeof! key is 'Object' and Object.keys(key).length > 0
      obj = key
      for k in Object.keys(obj)
        @addLibs k, obj[k]
      return @

    @init key
    names = [names] if typeof names is 'string'
    unless typeof! names is 'Array'
      throw new Error "lib(s) to add must be a String or Array"

    return unless names.length > 0
    @libs[key].libs = (@libs[key].libs or []).concat names
    @


Adder <<< FileIO

module.exports = Adder