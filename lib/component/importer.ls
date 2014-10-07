Component = require './component'

module.exports = class Importer
  (@obj, @components) ->
    @validate!
    @

  validate: ->
    unless typeof! @obj is 'Object'
      throw new Error "ComponentImporter must take an Object as first arg"

    unless typeof! @components is 'Object'
      throw new Error "component must be an Object"

  # TODO: refactor, avoid passing around callback!
  importAll: (cb) ->
    locationObjs = []
    for name, comp of @components
      locationObjs.push @component(name, comp).location-obj!

    for locationObj in locationObjs
      @importObj locationObj, cb

  importObj: (obj, cb) ->
    for key, locations of obj
      @importLoc locations, cb

  importLoc: (locations, cb)->
    for location in locations
      cb(@obj.directory + '/' + location);

  component: (name, comp) ->
    new Component name, comp

