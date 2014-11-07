# loads config from components file by key entry

BaseLoader = require '../base-loader'

GlobalConfig  = require '../../../../global-config'
gconf         = new GlobalConfig

module.exports = class JsonConfigLoader extends BaseLoader
  (@name, @path, @options = {}) ->
    @path ||= gconf.location 'components.dir'
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

    unless @exists @config-file!
      throw new Error "Components file #{@config-file!} does not exist"

  list: ->
    Object.keys @json-config!

  load-config: (name) ->
    name ||= @name
    unless @json-config![name]
      throw Error "No entry for #{name}"

    @json-config![name]

  has-config: (name) ->
    name ||= @name
    try
      !!@load-config(name)
    catch e
      false

  json-config: ->
    @_json-conf ||= @json @config-file!

  config-file: ->
    [@path, "index.json"].join '/'
