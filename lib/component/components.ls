/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */

ConfigLoader  = require '../config/loader'
Component     = require './component'
ListMutator   = require '../list-mutator'
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

  component-object: (name) ->
    return @load-listed-components![name] if @has-component name
    throw new Error "#{name} not found in list of registered components: #{util.inspect @list}"

  has-component: (name) ->
    @load-listed-components![name]

  components-list: ->
    @components-list ||= Object.keys @load-listed-components!

  load-listed-components: ->
    @_listed-components ||= @load-listed!

  load-listed: ->
    @configurations = {}
    for name in @list
      found = @config-loader(name).load-it!
      @configurations[name] = found if found
      if !found
        console.log "WARNING: #{name} config file not found"
    @configurations

  config-loader: (name) ->
    new ConfigLoader name, @path

  add-one: (name) ->
    return @ if @has name
    @list.push name
    @

  remove-one: (name) ->
    @_remove-item @list, name
    @

  index: (name) ->
    @list.index-of name

  # TODO> allow for callback output function
  output: (cb) ->
    @component(name).output cb
