FileIO        = require '../file-io'
ListMutator   = require '../list-mutator'

unless String.prototype.trim
  String.prototype.trim = ->
    @replace /^\s+|\s+$/g, ''

module.exports = class Select implements FileIO, ListMutator
  (@options = {}) ->
    @file = @options.file or './xlibs/select'
    @validate!
    @read!
    @content = @options.select or @content
    @

  validate: ->
    if @file and not @exists!
      throw new Error "File #{@file} does not exist"

  add-one: (name) ->
    return if @has name
    @clear!
    @lines!.push(name)
    @content = @lines!.join "\n"
    @

  remove-one: (name) ->
    @clear!
    @_remove-item @content, name
    @

  # cache lines!
  lines: ->
    @_lines ||= @content.split "\n" .filter( (x) -> !!x ).map( (x) -> x.trim! )

  clear: ->
    @_lines = void

  index: (name) ->
    @lines!.index-of name
