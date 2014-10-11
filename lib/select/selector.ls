FileIO          = require '../file-io'
ListMutator     = require '../list-mutator'
Configurator    = require '../config/configurator'

unless String.prototype.trim
  String.prototype.trim = ->
    @replace /^\s+|\s+$/g, ''

module.exports = class Select implements FileIO, ListMutator
  (@options = {}) ->
    @file = @options.file or './xlibs/selected'
    @validate!
    @read!
    @content = @options.select or @content
    @

  validate: ->
    if @file and not @exists!
      throw new Error "File #{@file} does not exist"

  add-one: (name) ->
    return false if @has name
    @clear!
    @lines!.push(name)
    @refresh!
    @

  refresh: ->
    @content = @lines!.join "\n"

  remove-one: (name) ->
    return false unless @has name
    @clear!
    @_remove-item @lines!, name
    @refresh!
    @

  install: ->
    for lib in list
      config(lib).install!

  build: (cb) ->
    for lib in list
      config(lib).build cb

  config: (lib) ->
    new Configurator(lib)

  # cache lines!
  lines: ->
    @_lines ||= @content.split "\n" .filter( (x) -> !!x ).map( (x) -> x.trim! )

  list:->
    @lines!

  clear: ->
    @_lines = void

  index: (name) ->
    @lines!.index-of name
