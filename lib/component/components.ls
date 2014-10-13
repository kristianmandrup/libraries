/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */

Component         = require './component'
ComponentConfig   = require './component-config'

ListMutator   = require '../list-mutator'
fs            = require 'fs'
util          = require 'util'

module.exports = class Components implements ListMutator
  (@list, @path) ->
    @path ||= './xlibs/components'
    @validate!
    @listed-components!
    @

  validate: ->
    unless typeof! @list is 'Array'
      throw new Error "Must be an Array, was: #{typeof! @list}"

  build: (cb) ->
    @all!.map (component) ~>
      component.build cb

  all: ->
    @component-names!.map (name) ~>
      @component name

  component: (name) ->
    comp = @component-object(name)
    return {} unless comp
    new Component name, comp

  component-object: (name) ->
    return @listed-components![name] if @has-component name
    void

  has-component: (name) ->
    @listed-components![name]

  install: ->
    for name in @list
      @component-config(name).install!

  component-names: ->
    @_component-names ||= Object.keys @listed-components!

  listed-components: ->
    @_listed-components ||= @load-listed!

  load-listed: ->
    @configurations = {}
    for name in @list
      found = @component-config(name).load-it!
      @configurations[name] = found if found
      if !found
        console.log "WARNING: #{name} config file not found"
    @configurations

  component-config: (name) ->
    new ComponentConfig name, @path

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
