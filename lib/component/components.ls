/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */

Component     = require './component'
ListMutator   = require '../list-mutator'
Registry      = require '../registry/registry'
fs            = require 'fs'
util          = require 'util'

module.exports = class Components implements ListMutator
  (@list, @path) ->
    @path ||= './xlibs/components'
    @validate!
    @load-listed-components!
    @

  validate: ->
    unless typeof! @list is 'Array'
      throw new Error "Must be an Array, was: #{typeof! @list}"

  component: (name) ->
    new Component name, @component-object(name)

  registry: ->
    @_reg ||= new Registry

  load-listed-components: ->
    @configurations = []
    for name in @list
      config = @load-config name
      configurations.push config if @valid-config config, name
    @configurations

  valid-config: (config, name) ->
    unless typeof! config is 'Object'
      throw new Error "Invalid config for component #{name}, was: #{util.inspect config}"


  load-config: (name) ->
    @load-from-local(name) or @load-from-registry(name) or @none(name)

  load-from-local: ->
    @load @component-file(name) if @has-local name

  load-from-registry: ->
    @load @registry-file(name) if @registry!.has name

  load: (file-path) ->
    try
      JSON.parse fs.readFileSync(file-path, 'utf8')
    catch err
      console.error err

  has-local: ->
    fs.existsSync @component-file(name)

  none: (name) ->
    @error "No Component config for #{name} could be found in local or global component configuration registries"

  error: (msg) ->
    console.error msg
    # throw new Error error

  registry-file: (name) ->
    @registry!.config-file name

  component-file: (name) ->
    [@path, "#{name}.json"].join '/'

  component-object: (name) ->


  add-one: (name) ->
    @list.push name
    @

  remove-one: (name) ->
    @_remove-item @list, name
    @

  index: (name) ->
    @list.index-of name

  output: ->
    @component(name).output!
