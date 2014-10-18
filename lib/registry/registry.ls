/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */


FileAdapter   = require './adapter/file-adapter'
UriAdapter    = require './adapter/uri-adapter'

module.exports = class Registry
  (@type, @options = {}) ->

  adapter: ->
    new @selected-adapter! @options

  selected-adapter: ->
    adapters[@type] or @bad-adapter!

  adapters:
    file: FileAdapter
    uri: UriAdapter

  bad-adapter: ->
    @error "Registry adapter #{@type} has not been registered"

  error: (msg)->
    throw new Error




