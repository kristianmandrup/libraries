/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:06
 */

FileIO  = require '../file-io'
# fs    = require 'fs'
fs      = require 'fs-extra'

module.exports = class Registry implements FileIO
  (@registry-uri, @local-registry-path) ->
    @registry-uri         ||= './xlibs/registry'
    @local-registry-path  ||= @registry-uri
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
    @json @index-file!

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg

  install: (name) ->
    try
      fs.copySync @config-file(name), @target-config(name)
    catch err
      @error err

  uninstall: (name) ->
    try
      fs.unlinkSync @target-config(name)
    catch err
      @error err
