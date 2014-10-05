module.exports = class RemapImporter
  (@obj, @remaps) ->
    @validate!
    @

  importAll: ->
    return unless @remaps
    @importRemaps!

  validate: ->
    unless typeof @obj is 'Object'
      throw new Error "RemapImporter must take an Object as first arg"

    unless typeof! @remaps is 'Object'
      throw new Error "remap must be an Object"

  importRemaps: ->
    for key in Object.keys @remaps
      @importRemap key, @remaps[key]

  importRemap: (remap, location) ->
    dir = @obj.directory + '/' + location
    options = {remap: remap}
    @obj.app.import(dir, options)
