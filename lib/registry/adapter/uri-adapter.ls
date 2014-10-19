FileIO        = require '../../file-io'
Installer     = require '../installer'
BaseAdapter   = require './base-adapter'
fs            = require 'fs-extra'

# remote          = require '../../remote'

sync-request = require 'sync-request'
retrieve     = require '../../../remote' .retrieve

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

  index-content: (options = {})->
    @_index-content ||= @retrieve!.then (body) ->
      body

  retrieve: ->
    deferred = Q.defer!
    retrieve @registry-libs-uri!, deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body

  retrieve-sync: ->
    sync-request('GET', @registry-libs-uri!).get-body!

  index: ->
    @index-content!.then (body) ->
      jsonlint.parse body

  list: ->
    @_list ||= @index!.then (obj) ->
      Object.keys obj

