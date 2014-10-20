/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */


FileAdapter   = require './adapter/file-adapter'
UriAdapter    = require './adapter/uri-adapter'

module.exports = class Registry
  (@type, @options = {}) ->
    @type ||= 'file'
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  install: (name) ->
    @adapter!.install name

  adapter: ->
    new @selected-adapter! @options

  selected-adapter: ->
    adapters[@type] or @bad-adapter!

  adapters:
    file: FileAdapter
    uri:  UriAdapter

  bad-adapter: ->
    @error "Registry adapter #{@type} has not been registered"

  error: (msg)->
    throw new Error




