FileAdapter   = require './adapter/file-adapter'
UriAdapter    = require './adapter/uri-adapter'

module.exports = class Registry
  (@options = {}) ->
    @parse!
    @validate!
    @

  parse: ->
    @type ||= @options.type or 'local'

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  install: (name) ->
    @adapter!.install name

  adapter: ->
    new @selected-adapter! @options

  selected-adapter: ->
    adapters[@type] or @bad-adapter!

  adapters:
    local:   LocalAdapter
    remote:  RemoteAdapter

  bad-adapter: ->
    @error "Registry adapter #{@type} has not been registered"

  error: (msg)->
    throw new Error




