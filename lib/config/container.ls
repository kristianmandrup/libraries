Libs = require '../library/libs'
util = require 'util'
Components  = require '../component/components'
Libs        = require '../library/libs'

module.exports = class ConfigContainer
  (@container, @config = {}) ->
    @validate!
    @

  validate: ->
    unless typeof! @container is 'Object'
      throw new Error "Container must be an Object, was: #{util.inspect @container}"
    unless typeof! @config is 'Object'
      throw new Error "Config must be an Object, was: #{util.inspect @config}"

  component-list: ->
    @_component-list ||= @container.components or []

  libs: ->
    @_libs ||= @container.libs or {}

  libs-list: ->
    @_libs-list ||= Object.keys @libs!

  is-component: (name) ->
    @component-list!.index-of(name) > -1

  is-lib: (name) ->
    @libs-list!.index-of(name) > -1

  has: (name) ->
    @is-component(name) or @is-lib(name)

  components: ->
    @_components ||= new Components @component-list!

  libraries: ->
    @_libraries ||= new Libs @libs!

  build: (cb) ->
    @install!
    @libraries!.build(cb).concat(@components!.build cb)

  install: ->
    @components!.install!

  output: (list, cb) ->
    for lib in list
      @output-lib(name, cb) or @output-component(name, cb)

  output-component: (name, cb) ->
    return unless @is-component name
    @components!.output name, cb

  output-lib: (name, cb) ->
    return unless @is-lib name
    @libraries!.output name, cb


