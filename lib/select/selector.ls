FileIO = require '../file-io'

unless String.prototype.trim
  String.prototype.trim = ->
    @replace /^\s+|\s+$/g, ''

module.exports = class Select implements FileIO
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

  add: (names) ->
    names = @_normalize names
    for name in names
      @add-one name
    @

  remove-one: (name) ->
    return unless @has name
    @clear!
    @content.splice @index(name, 1)
    @

  remove: (names) ->
    names = @_normalize names
    for name in names
      @remove-one name
    @

  _normalize: (names) ->
    if typeof! names is 'String' then [names] else names

  # cache lines!
  lines: ->
    @_lines ||= @content.split "\n" .filter( (x) -> !!x ).map( (x) -> x.trim! )

  clear: ->
    @_lines = void

  index: (name) ->
    @lines!.index-of name

  has: (name) ->
    @index(name) > -1
