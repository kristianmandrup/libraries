FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../../base-adapter'
fs            = require 'fs-extra'

sync-request = require 'sync-request'
retrieve     = require '../../../util/remote' .retrieve

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

module.exports = class RegistryPackageAdapter extends BaseAdapter implements FileIO
  (@options = {}) ->
    @type ||= 'bower'
    @installer-type = @options.installer || 'file'
    @registry-path = @options.path or @default-path!
    super ...

  default-path: ->
    gconf.dir-for @type

  validate: ->
    unless typeof! @registry-path is 'String'
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
    @retrieve-body @registry-libs-uri!

  retrieve-body: (uri) ->
    deferred = Q.defer!
    fs.readFile uri, deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body

  index: ->
    @index-content!.then (body) ->
      jsonlint.parse body

  list: ->
    @_list ||= @index!.then (obj) ->
      Object.keys obj

