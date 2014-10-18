/**
 * User: kristianmandrup
 * Date: 17/10/14
 * Time: 21:16
 */

module.exports = class BaseInstaller
  (@name, @content, @options = {}) ->
    @file ||= @options.file
    @validate!
    @log = @options.log || console.log

  validate: ->
    unless @exists @file
      throw new Error "Target file #{@file} does not exist"

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name must be a String, was: #{@name}"

  installing: ->
    @log "installing: #{@name}"

  uninstalling: ->
    @log "uninstalling: #{@name}"