/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */
Lib     = require './lib'
util    = require 'util'

module.exports = class Libs
  (@libs) ->
    @validate!
    @

  validate: ->
    unless typeof! @libs is 'Object'
      throw new Error "Must be an Object"

  build: (cb) ->
    @building!
    Object.keys(@libs).map (name) ->
      @output key, cb

  building: ->
    console.log " - all libs"

  # overwrite if name exists and not force: true
  add: (name, lib) ->
    if typeof! name is 'Object' and Object.keys(name).length is 1
      key = Object.keys(name).0
      lib = name[key]
      return @add key, lib

    @libs[name] = @validated-lib name, lib
    @

  validated-lib: (name, lib) ->
    switch typeof! lib
    when 'String'
      new Lib name, lib
    when 'Object'
      Lib.fromObject name, lib
    default
      throw new Error "lib must be a String or Object, was: #{typeof lib}"

  remove: (name) ->
    delete @libs[name] if @libs[name]
    @

  location: (name) ->
    libs[name].location

  output: (name, cb) ->
    libs[name].output cb

