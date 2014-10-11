FileIO        = require '../file-io'
Registry      = require '../registry/registry'
fs            = require 'fs'
util          = require 'util'

module.exports = class ComponentConfig implements FileIO
  (@name, @path) ->
    @validate!
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of config to load must be a String, was: #{@name}"

    unless typeof! @path is 'String'
      throw new Error "Name of path to load from must be a String, was: #{@path}"

  load-it: ->
    @valid-config @load-config!

  build: ->
    throw new Error "Can't build this :P"

  install: (options = {}) ->
    if @should-install options
      @registry!.install @name

  should-install: (options = {}) ->
    options.force or @not-local!

  valid-config: (config) ->
    return config if typeof! config is 'Object'
    throw new Error "Invalid config for component #{@name}, was: #{util.inspect config}"

  load-config: ->
    @load-from-local! or @load-from-registry! or @none!

  load-from-local: ->
    @load @component-file! if @has-local!

  load-from-registry: ->
    @load @registry-file! if @registry!.has @name

  registry: ->
    @_registry ||= new Registry

  load: (file-path) ->
    try
      @json file-path
    catch err
      console.error err

  not-local: (name) ->
    not @has-local(name)

  has-local: (name) ->
    name ||= @name
    @exists @component-file(name)

  none: ->
    @error "No Component config for #{@name} could be found in local or global component configuration registries"

  registry-file: ->
    @registry!.config-file @name

  component-file: (name) ->
    name ||= @name
    [@path, "#{name}.json"].join '/'

  error: (msg) ->
    console.error msg
    # throw new Error error
