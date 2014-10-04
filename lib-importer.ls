module.exports = class LibImporter
  (@obj, @libs) ->
    @validate!
    @

  validate: ->
    unless typeof! @libs is 'Array'
      throw new Error "libs must be an Array"

  importLib: (location) ->
    @obj.app.import(@obj.directory + '/' + location);

  importAll: ->
    return unless @libs
    for location in @libs
      @importLib location
