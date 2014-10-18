/**
 * User: kristianmandrup
 * Date: 17/10/14
 * Time: 20:31
 */

FileIO      = require '../../file-io'
Installer   = require '../installer'

module.exports = class BaseAdapter implements FileIO
  (@options = {}) ->
    @registry-uri         ||= @options.registry
    @local-registry-path  = @options.local    or './xlibs/components'
    @validate!
    @

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String"

    unless typeof! @local-registry-path is 'String'
      throw new Error "localRegistryPath must be a String, was #{@local-registry-path}"

  installer: ->
    @_installer ||= new Installer @options.installer

  list: ->
    @_list ||= @index!.registry

  has: (name) ->
    @list!.index-of(name) > -1

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg