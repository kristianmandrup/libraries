# loads config from components file by key entry

BaseConfigLoader = require './base'

module.exports = class JsonConfigLoader extends BaseConfigLoader
  (@name, @path, @options = {}) ->
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

    unless @exisits @config-file!
      throw new Error "Components file #{@config-file!} does not exist"

  load-config: (name) ->
    @json-config![name]

  has-config: (name) ->
    name ||= @name
    !!@load-config! name

  json-config: ->
    name ||= @name
    @_json-conf ||- @json @config-file!

  config-file: ->
    [@path, "components.json"].join '/'
