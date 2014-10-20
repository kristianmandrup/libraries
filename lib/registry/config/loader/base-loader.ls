FileIO     = require '../../../util/file-io'

GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig

module.exports = class BaseConfigLoader implements FileIO
  (@name, @path, @options = {}) ->
    @path ||= gconf.components!.dir!
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"


