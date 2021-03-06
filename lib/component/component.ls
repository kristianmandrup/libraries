util    = require 'util'
flatten = require '../util/array' .flatten

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
    @_location-obj ||= @_loc-obj!

  _loc-obj: ->
    obj = {}
    for name in ['main', 'scripts', 'styles', 'images', 'fonts', 'files']
      paths = @locations name
      obj[name] = paths if paths
    obj

  locations: (type) ->
    conf = @comp[type]
    return unless conf
    conf.files.map (file) ~>
      @location conf.dir, file

  # filter out any null value from path
  location: (dir, file) ->
    [@base-dir, dir, file].filter( (item) -> !!item ).join '/'

  build: (cb) ->
    @building!
    @output cb || @emit

  building: ->
    console.log " - component: #{@name}"

  emit: (locations) ->
    locations.map (location) ->
      "app.import('#{location}');"

  types: ->
    Object.keys @location-obj!

  output: (cb) ->
    @flat-output cb

  flat-output: (cb) ->
    flatten @type-output(cb)

  # TODO: font support -> destDir: 'font'
  # TODO: Sass suppport via class path (see ember/cli/fontawesome-sass)
  # TODO: exports for AMD remap via Petals
  type-output: (cb) ->
    @types!.map (key) ~>
      cb @location-obj![key]

