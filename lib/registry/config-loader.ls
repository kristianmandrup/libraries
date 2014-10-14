/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:26
 */
RemoteConfigLoader  = require './config-loader/remote'
LocalConfigLoader   = require './config-loader/local'

module.exports = class ConfigLoader
  (@name, @path, @options = {}) ->
    @path ||= @components-path!
    @validate!
    @

  components-path: ->
    if @options.env then @env-path! else './xlibs/components'

  env-path: ->
    ['./xlibs', @options.env,  'components'].join '/'


  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"

    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

  load-config: ->
    @local!.load-config! or @remote!.load-config! or @none-loaded!

  local: ->
    @_local ||= new LocalConfigLoader @name, @path

  remote: ->
    @_remote ||= new RemoteConfigLoader @name

  none-loaded: ->
    @error "Component config for #{@name} could not be found in either local or global component configuration registries"

  error: (msg) ->
    console.error msg
    # throw new Error error