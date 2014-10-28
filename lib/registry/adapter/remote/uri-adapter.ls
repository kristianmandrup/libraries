FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../../base-adapter'
fs            = require 'fs-extra'

sync-request = require 'sync-request'
retrieve     = require '../../../util/remote' .retrieve

Github  = require './repo/github'

module.exports = class RegistryUriAdapter extends BaseAdapter  implements FileIO
  (@options = {}) ->
    @registry-uri = @options.uri or @default-uri!
    @installer-type = @options.installer || 'file'
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

  installer: (type) ->
    type ||= @installer-type
    @_installer ||= new Installer type

  install: (name) ->
    @installer!.install source: @read-config(name), target: @target-config(name)

  read-config: (name) ->
    @index![name]

  registry-libs-uri: ->
    @registry-location-parts!.join '/'

  # filter out any undefined parts
  registry-location-parts: ->
  [@registry-uri, @registries-path!, @libs-file!].filter (part) -> !!part

  registries-path: ->
    'registries'

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

