RemoteLoader      = require './config/loader/remote-loader'
LocalLoader       = require './config/loader/local-loader'
CompositeLoader   = require './config/loader/composite-loader'

GlobalConfig  = require '../global-config'
gconf         = new GlobalConfig

module.exports = class ConfigLoader
  (@name, @path, @options = {}) ->
    @path ||= @components-path!
    @validate!
    @

  components-path: ->
    if @options.env then @env-path! else gconf.location 'components.dir'

  env-path: ->
    [gconf.dir, @options.env,  'components'].join '/'


  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"

    unless typeof! @path is 'String'
      throw new Error "Path of config to load must be a String, was: #{@path}"

  load-config: ->
    @local!.load-config! or @remote!.load-config! or @none-loaded!

  composite: ->
    @_composite ||= new CompositeLoader @name, @path, @options

  local: ->
    @_local ||= new LocalLoader @name, @path, @options

  remote: ->
    @_remote ||= new RemoteLoader @name, @options

  none-loaded: ->
    @error "Component config for #{@name} could not be found in either local or global component configuration registries"

  error: (msg) ->
    console.error msg
    # throw new Error error