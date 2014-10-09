/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */
module.exports = class Libs
  (@libs) ->
    @validate!
    @

  validate: ->
    unless typeof! @libs is 'Object'
      throw new Error "Must be an Object"

  # overwrite if name exists and not force: true
  add: (name, lib) ->
    if typeof! name is 'Object' and Object.keys(name).length is 1
      key = Object.keys(name).0
      lib = name[key]
      return @add key, lib

    @libs[name] = @validated-lib lib
    @

  validated-lib: (lib) ->
    unless typeof! lib is 'String' or typeof! lib is 'Object'
      throw new Error "lib must be a String or Object, was: #{typeof lib}"
    lib

  remove: (name) ->
    delete @libs[name] if @libs[name]
    @

  output: (name) ->
    "app.import('#{@libs[name]}');"
