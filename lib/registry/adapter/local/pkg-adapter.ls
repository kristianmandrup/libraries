FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../base-adapter'

fs              = require 'fs-extra'
util            = require 'util'
jsonlint        = require 'jsonlint'

Q = require 'q'

is-blank = (str) ->
    !str or /^\s*$/.test str

sync-request = require 'sync-request'
retrieve     = require '../../../util/remote' .retrieve

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

module.exports = class RegistryPackageAdapter extends BaseAdapter implements FileIO
  (@options = {}) ->
    @type ||= 'bower'
    @pkg-name = @options.pkg-name or 'libraries'
    @installer-type = @options.installer || 'file'
    @pkg-path = gconf.dir-for @type
    super ...

  validate: ->
    unless typeof! @pkg-path is 'String'
      throw new Error "pkg path must be a String, was:"

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
    [@pkg-path, @pkg-name, @registries-path!, @libs-file!].filter (part) -> !!part

  registries-path: ->
    'registry'

  libs-file: ->
    "#{@type}-libs.json"

  index-content: (options = {})->
    @_index-content ||= @retrieve!then (body) ->
      body

  retrieve: ->
    @retrieve-body @registry-libs-uri!

  retrieve-body: (uri) ->
    deferred = Q.defer!
    fs.readFile uri, 'utf-8', deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body

  index: ->
    @index-content!then (body) ->
      jsonlint.parse body

  list: ->
    @_list ||= @index!.then (obj) ->
      Object.keys obj

