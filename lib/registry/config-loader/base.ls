/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:37
 */

FileIO = require '../../file-io'

module.exports = class BaseConfigLoader implements FileIO
  (@name, @path) ->
    @path ||= './xlibs/components'
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"

  load-config: ->
    @load @config-file! if @has-config!

  load: (file-path) ->
    try
      @json file-path
    catch err
      @error err

  error: (msg) ->
    console.error msg
    # throw new Error error