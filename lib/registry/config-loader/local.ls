/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:30
 */
BaseConfigLoader = require './base'

module.exports = class LocalConfigLoader extends BaseConfigLoader
  (@name, @path) ->
    super ...
    @validate!
    @

  validate: ->
    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

  has-config: (name) ->
    name ||= @name
    @exists @config-file(name)

  config-file: (name) ->
    name ||= @name
    [@path, "#{name}.json"].join '/'
