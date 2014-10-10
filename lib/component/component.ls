util = require 'util'

module.exports = class Component
  (@name, @comp) ->
    @validate!
    @base-dir = @comp.dir
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of component must be a String, was: #{util.inspect @name}"

    unless @comp
      throw new Error "Missing config Object argument"

    unless typeof! @comp is 'Object'
      throw new Error "component must be an Object, was: #{util.inspect @comp}"

  location-obj: ->
    obj = {}
    for name in ['scripts', 'styles', 'sass', 'fonts']
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

  # TODO: allow for callback output function
  # TODO: Sass suppport via class path (see ember/cli/fontawesome-sass)
  # TODO: support exports for AMD remap
  output: (cb) ->
    imports = []
    for key, location in @location-obj!
      imports.push "app.import('#{location}');"
    imports

