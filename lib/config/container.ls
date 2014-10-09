module.exports = class Container
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

  output: (list) ->
    for lib in list
      @output-lib(name) or @output-component(name)

  output-component: (name) ->
    return unless @is-component name
    @components!.output name

  output-lib: (name) ->
    return unless @is-lib name
    @libraries!.output name


