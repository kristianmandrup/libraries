module.exports = class LibImporter
  (@obj, @libs) ->
    @validate!
    @

  validate: ->
    unless typeof @obj is 'Object'
      throw new Error "LibImporter must take an Object as first arg"

    unless typeof! @libs is 'Array'
      throw new Error "libs must be an Array"

  importLib: (location) ->
    @obj.app.import(@obj.directory + '/' + location);

  importAll: ->
    return unless @libs
    for location in @libs
      @importLib location
