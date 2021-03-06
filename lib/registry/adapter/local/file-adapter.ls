FileIO        = require '../../../util/file-io'
Installer     = require '../../config/installer'
BaseAdapter   = require '../base-adapter'
fs            = require 'fs-extra'

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

module.exports = class RegistryFileAdapter extends BaseAdapter implements FileIO
  (@options = {}) ->
    @registry-uri         = @options.registry or gconf.location 'registry.dir'
    @local-registry-path  = @options.local    or gconf.location 'components.dir'
    @validate!
    @

  read-config: (name) ->
    @config ||= fs.readFileSync @config-file(name)

  index-file: ->
    [@registry-uri, 'index.json'].join '/'

  index: ->
    @_index ||= @json @index-file!

  list: ->
    @_list ||= @index!.registry

  has: (name) ->
    @list!.index-of(name) > -1

  config-file: (name) ->
    [@registry-uri, "#{name}.json"].join '/'

  target-config: (name) ->
    [@local-registry-path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg