/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */
Lib     = require './lib'
util    = require 'util'

module.exports = class Libs
  (libs) ->
    @libs = {} <<< libs
    @validate!
    @parse!
    @

  validate: ->
    unless typeof! @libs is 'Object'
      throw new Error "Must be an Object"

  parse: ->
    @libraries ||= []
    for name in Object.keys(@libs)
      @libraries[name] = @validated-lib name, @libs[name]

  library-names: ->
    Object.keys @libraries

  build: (cb) ->
    @building!
    @library-names!.map (name) ~>
      @library(name).output cb

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
      Lib.from-object name, lib
    when 'Array'
      new Lib name, lib[0], lib[1]
    default
      throw new Error "lib must be a String or Object, was: #{typeof lib}"

  remove: (name) ->
    delete @libraries[name] if @library(name)
    @

  location: (name) ->
    @library(name).location

  library: (name) ->
    @libraries[name]

  output: (name, cb) ->
    @library(name).output cb

