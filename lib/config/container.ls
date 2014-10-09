module.exports = class Container
  (@obj) ->

  components: ->
    @_components ||= @obj.components or []

  libs: ->
    @_libs ||= @obj.libs or {}

  libs-list: ->
    @_libs-list ||= Object.keys @libs!

  is-component: (name) ->
    @components!.index-of(name) > -1

  is-lib: (name) ->
    @libs!.index-of(name) > -1

  has: (name) ->
    @is-component(name) or @is-lib(name)
