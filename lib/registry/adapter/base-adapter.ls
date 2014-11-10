FileIO      = require '../../util/file-io'
Installer   = require '../config/installer'
Enricher    = require '../config/enricher'
Normalizer  = require '../config/normalizer'

GlobalConfig  = require '../../global-config'
gconf         = new GlobalConfig

util = require 'util'

module.exports = class BaseAdapter implements FileIO
  (@options = {}) ->
    @registry-uri         = @options.registry or @default-registry-uri!
    @local-registry-path  = @options.local or @default-components-dir!
    @validate!
    @

  default-components-dir: ->
    gconf.location 'components.dir' or './xlibs/components/'

  default-registry-uri: ->
    "https://raw.githubusercontent.com/kristianmandrup/libraries/master/registry"

  validate: ->
#    unless typeof! @registry-uri is 'String'
#      throw new Error "registryUri must be a String"
#
#    unless typeof! @local-registry-path is 'String'
#      throw new Error "localRegistryPath must be a String, was #{@local-registry-path}"

  enricher: (config) ->
    @_enricher ||= new Enricher config, @options

  enrich: (config) ->
    @config = @enricher(config).enrich!

  normalizer: (config) ->
    @_normalizer ||= new Normalizer config, @options

  normalize: (config) ->
    @config = @normalizer(config).normalize!

  # each step changes config
  enrich-and-normalize: (name) ->
    @read-config(name).then (res) ~>
      # @enrich res
      @normalize res

  install: (name) ->
    @installer!.install name, source: @enriched-config(name), target: @target-config(name)

  enriched-config: (name) ->
    @enrich-and-normalize!

  installer: (type) ->
    type ||= @installer-type
    @_installer ||= new Installer type

  list: ->
    @_list ||= @index!registry

  has: (name) ->
    @list!.index-of(name) > -1

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg