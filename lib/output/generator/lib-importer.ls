module.exports = class LibImporter
  (@obj, @libs) ->
    @validate!
    @

  validate: ->
    unless typeof! @obj is 'Object'
      throw new Error "LibImporter must take an Object as first arg"

    unless typeof! @libs is 'Object'
      throw new Error "libs must be an Object"

  importLib: (location) ->
    @obj.app.import(@obj.directory + '/' + location);

  importAll: ->
    for name, location of @libs
      @importLib key + '/' + location




