Libs = require '../library/libs'

module.exports = class ConfigContainer
  (@obj, @config) ->

  comps: ->
    @_comps ||= @obj.components or []

  libs: ->
    @_libs ||= @obj.libs or {}

  libs-list: ->
    @_libs-list ||= Object.keys @libs!

  is-component: (name) ->
    @comps!.index-of(name) > -1

  is-lib: (name) ->
    @libs-list!.index-of(name) > -1

  has: (name) ->
    @is-component(name) or @is-lib(name)

  components: ->
    @_components ||= new Components @comps!

  libraries: ->
    @_libraries ||= new Libs @libs!

  build: (cb) ->
    @libraries!.build(cb).concat(@components!.build cb)

  output: (list, cb) ->
    for lib in list
      @output-lib(name, cb) or @output-component(name, cb)

  output-component: (name, cb) ->
    return unless @is-component name
    @components!.output name, cb

  output-lib: (name, cb) ->
    return unless @is-lib name
    @libraries!.output name, cb


