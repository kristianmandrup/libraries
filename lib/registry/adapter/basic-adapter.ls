GlobalConfig  = require '../../global-config'
gconf         = new GlobalConfig

module.exports = class BasicRegistryAdapter
  (@options = {}) ->
    @type ||= @options.type or @default-type!
    @installer-type = @options.installer or @default-installer!
    @adapter-type   = @options.adapter or @default-adapter!
    super ...
    @validate!
    @

  default-type: ->
    gconf.get \registry.adapter.type or 'bower'

  default-installer: ->
    gconf.get \registry.adapter.installer or 'json'

  default-adapter: ->
    gconf.get \registry.adapter.name or 'pkg'

  validate: ->
    unless typeof! @type is 'String'
      throw Error "Type must be a String, was: #{@type}"

    unless typeof! @adapter-type is 'String'
      throw Error "adapter type must be a String, was: #{@adapter-type}"

  load: ->
    @adapter!.load!

  install: ->
    @adapter!.install @installer-type

  adapter: ->
    clazz = @selected-adapter!
    new clazz @options

  selected-adapter: ->
    @adapter[@adapter-type] or @bad-adapter!

  bad-adapter: ->
    throw new Error "unknown adapter #{@adapter-type}"