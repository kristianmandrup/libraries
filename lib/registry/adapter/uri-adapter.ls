FileIO        = require '../../file-io'
Installer     = require '../installer'
BaseAdapter   = require './base-adapter'
fs            = require 'fs-extra'

# remote          = require '../../remote'

sync-request = require 'sync-request'

Github  = require './repo/github'

module.exports = class RegistryUriAdapter extends BaseAdapter  implements FileIO
  (@options = {}) ->
    @registry-uri = @options.registry-uri or @default-uri!
    @type ||= 'bower'
    super ...

  default-uri: ->
    @default-repo!.registry-path @options.repo

  default-repo: ->
    new Github

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String, was:"

    unless typeof! @local-registry-path is 'String'
      throw new Error "localRegistryPath must be a String, was #{@local-registry-path}"

  installer: ->
    @_installer ||= new Installer

  install: (name) ->
    @installer.install source: @read-config(name), target: @target-config(name)

  read-config: (name) ->
    @index![name]

  registry-libs-uri: ->
    [@registry-uri, @libs-file!].join '/'

  libs-file: ->
    "#{@type}-libs.json"

  # TODO: Make async! allow download for local caching!
  index-content: (options = {})->
    @_index-content ||= @retrieve!

  # TODO: Make async
  retrieve: ->
    sync-request('GET', @registry-libs-uri!).get-body!

  index: ->
    JSON.parse @index-content!

  list: ->
    @_list ||= Object.keys @index!

