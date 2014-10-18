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

  select-adapter: ->
    switch @type
    when 'file'
      FileAdapter
    when 'uri'
      UriAdapter
    else
      throw new Error "unknown Registry adapter #{@type}"




