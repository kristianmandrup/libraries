# loads config from file of same name

BaseConfigLoader = require './base-loader'

module.exports = class FileConfigLoader extends BaseConfigLoader
  (@name, @path, @options = {}) ->
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

  has-config: (name) ->
    name ||= @name
    @exists @config-file(name)

  load-config: (name) ->
    @json @config-file(name)

  config-file: (name) ->
    name ||= @name
    [@path, "#{name}.json"].join '/'
