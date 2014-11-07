FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../base-adapter'
fs            = require 'fs-extra'
Q = require 'q'

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

sync-request = require 'sync-request'
retrieve     = require '../../../util/remote' .retrieve

module.exports = class RegistryUriAdapter extends BaseAdapter implements FileIO
  (@options = {}) ->
    @installer-type = @options.installer or @default-installer!
    @repo-type      = @options.repo-type or @default-repo!
    @type           = @options.type or @default-type!
    @registry-uri   = @options.uri or @repo-uri!
    super ...
    @validate!
    @

  default-type: ->
    gconf.get 'registry.adapter.type' or 'bower'

  default-installer: ->
    gconf.get 'registry.adapter.installer' or 'file'

  default-repo: ->
    gconf.get 'registry.adapter.repo' or 'github'

  repo-uri: ->
    clazz = @repo-clazz!
    repo = new clazz
    repo.registry-path @options.repo

  repo-clazz: ->
    @repos![@repo-type]

  repos: ->
    github: require './repo/github'

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String, was:"

  read-config: (name) ->
    @config ||= @index![name]

  registry-libs-uri: ->
    @registry-location-parts!.join '/'

  # filter out any undefined parts
  registry-location-parts: ->
    [@registry-uri, @registries-path!, @libs-file!].filter (part) -> !!part

  registries-path: ->
    'registry'

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

