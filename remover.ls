FileIO = require './file-io'

Remover =
  # add one or more libs to libraries file
  # call examples
  #   .addLibs 'bower', 'dist/ember-validations.js'
  #   .addLibs 'bower', ['dist/ember-validations.js', 'dist/ember-forms.js']
  #   .addLibs bower: 'dist/ember-validations.js', vendor: ['dist/xyz.js']
  removeLibs: (key, names) ->
    if typeof! key is 'Object' and Object.keys(key).length > 0
      obj = key
      for k in Object.keys(obj)
        @removeLibs k, obj[k]
      return @

    @init key
    names = [names] if typeof names is 'string'
    unless typeof! names is 'Array'
      throw new Error "lib(s) to remove must be a String or Array"

    return unless names.length > 0
    for name in names
      @removeLib key, name
    @

  removeLib: (key, name) ->
    unless typeof! name is 'String'
      throw new Error "lib to remove must be a String"
    index = @libs[key].libs.index-of name
    @libs[key].libs.splice(index, 1) if index > -1
    @

  # add one or more libs to libraries file
  # call examples
  #   .addRemaps 'bower', {'jquery/core': 'dist/core/jquery.js'}
  removeRemaps: (key, map-names) ->
    @init key
    map-names = [map-names] if typeof map-names is 'string'
    unless typeof! map-names is 'Array'
      throw new Error "Map names to remove must be an Array or String"

    return unless map-names.length > 0

    @libs[key].remap ||= {}
    for map-name in map-names
      @removeRemap key, map-name
    @

  removeRemap: (key, map-name) ->
    delete @libs[key].remap[map-name] if @libs[key].remap[map-name]
    @

Remover <<< FileIO

module.exports = Remover