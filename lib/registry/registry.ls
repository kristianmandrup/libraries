/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */

FileIO = require 'file-io'

module.exports = class Registry implements FileIO
  (@uri-root) ->
    @uri-root ||= './xlibs/registry'
    @

  index-file: ->
    [@uri-root, 'index.json'].join '/'

  index: ->
    @read index-file

  config-file: (name) ->
    [@uri-root, "#{name}.json"].join '/'

  target-config: (name) ->
    [@target-path, "#{name}.json"].join '/'

  install: (name, @target-path = './xlibs/components') ->
    fs.copy @config-file(name), @target-config(name)

  uninstall: (name, @target-path = './xlibs/components') ->
    fs.delete @target-config(name)
