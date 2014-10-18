FileIO        = require '../../file-io'
Installer     = require '../installer'
BaseAdapter   = require './base-adapter'
fs            = require 'fs-extra'

remote          = require '../../remote'
retrieveRemote  = remote.retrieveRemote

registry-uri = 'https://raw.githubusercontent.com/kristianmandrup/libaries/master/registry'

module.exports = class RegistryUriAdapter extends BaseAdapter  implements FileIO
  (@options = {}) ->
    @registry-uri  = @options.registry or registry-uri
    super ...

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String, was:"

    unless typeof! @local-registry-path is 'String'
      throw new Error "localRegistryPath must be a String, was #{@local-registry-path}"

  installer: ->
    @_installer ||= new Installer

  install: (name, type = 'bower') ->
    @installer.install source: @read-config(name, type), target: @target-config(name)

  read-config: (name, type) ->
    retrieveRemote @registry-uri-for(type), (body) ->
      body

  registry-uri-for: (type) ->
    [@registry-uri, @registry-file(type)].join '/'

  registry-file: (type) ->
    "#{type}-libs.json"

  index-content: ->
    @_index-content ||= retrieveRemote @registry-uri, (body) ->
      body

  index: ->
    @json @index-content!

  list: ->
    @_list ||= @index!.registry

