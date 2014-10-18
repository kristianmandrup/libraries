module.exports = class BaseConfigLoader
  (@name, @path, @options = {}) ->
    @path ||= './xlibs/components'
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"


