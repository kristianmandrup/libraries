module.exports = class Component
  (@name, @comp) ->
    @validate!
    @base-dir = @comp.dir
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of component must be a String"

    unless typeof! @comp is 'Object'
      throw new Error "component must be an Object"

  location-obj: ->
    obj = {}
    for name in ['scripts', 'styles', 'fonts']
      paths = @locations name
      obj[name] = paths if paths
    obj

  locations: (type) ->
    conf = @comp[type]
    return unless conf
    for file in conf.files
      @location conf.dir, file

  location: (dir, file) ->
    [@base-dir, dir, file].filter( (item) -> !!item ).join '/'

