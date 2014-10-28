FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../../base-adapter'
fs            = require 'fs-extra'

sync-request = require 'sync-request'
retrieve     = require '../../../util/remote' .retrieve

module.exports = class RegistryUriAdapter extends BaseAdapter  implements FileIO
  (@options = {}) ->
    @installer-type = @options.installer or 'file'
    @repo-type = @options.repo-type or 'github'
    @type ||= 'bower'
    @registry-uri = @options.uri or @repo-uri!
    super ...
    validate!
    @

  repo-uri: ->
    clazz = @repo-clazz!
    new clazz.registry-path @options.repo

  repo-clazz: ->
    @repos![@repo-type]

  repos: ->
    github: require './repo/github'

  validate: ->
    unless typeof! @registry-uri is 'String'
      throw new Error "registryUri must be a String, was:"

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

