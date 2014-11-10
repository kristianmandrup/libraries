util    = require 'util'

module.exports = class Lib
  (@name, @location, @options = {}) ->
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name must be an String, was: #{util.inspect @name}"

    unless typeof! @location is 'String'
      throw new Error "Location must be a String, was: #{util.inspect @location}"

    unless typeof! @options is 'Object'
      throw new Error "Options must be an Object, was: #{util.inspect @options}"

  @fromObject = (name, obj) ->
    unless obj.at
      throw new Error "Library #{name} must have an .at key"
    new Lib name, obj.at, obj.opts

  output: (cb) ->
    cb ||= @emit
    cb @location

  emit: (location) ->
    "app.import('#{location}');"