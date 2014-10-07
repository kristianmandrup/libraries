/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 13:56
 */

module.exports = class LibConfigurator implements Reader
  (@file) ->
    @file ||= './xlibs/lib-config.json'
    @bower!
    @

  config: ->
    @content.config or {}

  part: (name) ->
    @content[name] or {}

  components: (name) ->
    @part(name).components or []

  libs: (name) ->
    @part(name).libs or {}
