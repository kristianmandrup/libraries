/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */

FileIO  = require '../file-io'
# fs    = require 'fs'
fs      = require 'fs-extra'

module.exports = class Registry implements FileIO
  (@options = {}) ->
    @registry-uri         = @options.registry or './xlibs/registry'
    @local-registry-path  = @options.local    or './xlibs/components'
    @validate!
    @

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String"

    unless typeof! @local-registry-path is 'String'
      throw new Error "localRegistryPath must be a String, was #{@local-registry-path}"

  index-file: ->
    [@registry-uri, 'index.json'].join '/'

  index: ->
    @_index ||= @json @index-file!

  list: ->
    @_list ||= @index!.registry

  has: (name) ->
    @list!.index-of name > -1

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg

  install: (name) ->
    try
      @installing name
      fs.copySync @config-file(name), @target-config(name)
    catch err
      @error err

  installing: (name) ->
    console.log "installing: #{name}"

  uninstall: (name) ->
    try
      @uninstalling name
      fs.unlinkSync @target-config(name)
    catch err
      @error err

  uninstalling: (name) ->
    console.log "uninstalling: #{name}"
