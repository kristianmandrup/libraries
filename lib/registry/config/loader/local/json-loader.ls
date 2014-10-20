# loads config from components file by key entry

BaseConfigLoader = require './base-loader'

module.exports = class JsonConfigLoader extends BaseConfigLoader
  (@name, @path, @options = {}) ->
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
    !!@load-config! name

  json-config: ->
    @_json-conf ||= @json @config-file!

  config-file: ->
    [@path, "index.json"].join '/'
