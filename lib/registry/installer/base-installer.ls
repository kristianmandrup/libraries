/**
 * User: kristianmandrup
 * Date: 17/10/14
 * Time: 21:16
 */

module.exports = class BaseInstaller
  (@name, @content, @file, @options = {}) ->
    @validate!
    @log = @options.log || console.log

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name must be a String, was: #{@name}"

    unless typeof! @content is 'String'
      throw new Error "Source of config must be a String, was: #{@content}"

  installing: ->
    @log "installing: #{@name}"

  uninstalling: ->
    @log "uninstalling: #{@name}"