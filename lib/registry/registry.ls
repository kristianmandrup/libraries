/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */

FileIO = require 'file-io'

module.exports = class Registry implements FileIO
  (@uri-root, @target-path) ->
    @registry-uri         ||= './xlibs/registry'
    @local-registry-path  ||= @uri-root
    @validate!
    @

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "uri root must be a String"

  index-file: ->
    [@registry-uri, 'index.json'].join '/'

  index: ->
    @read index-file

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  install: (name, @target-path = './xlibs/components') ->
    fs.copy @config-file(name), @local-registry-path(name)

  uninstall: (name, @target-path = './xlibs/components') ->
    fs.delete @target-config(name)
