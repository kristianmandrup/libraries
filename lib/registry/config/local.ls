BaseConfigLoader = require './base'

module.exports = class LocalConfigLoader extends BaseConfigLoader
  (@name, @path) ->
    super ...
    @validate!
    @

