FileIO          = require '../util/file-io'
ListMutator     = require '../util/list-mutator'
Configurator    = require '../config/configurator'
Registry        = require '../registry/registry'

GlobalConfig  = require '../global-config'
gconf         = new GlobalConfig

unless String.prototype.trim
  String.prototype.trim = ->
    @replace /^\s+|\s+$/g, ''

module.exports = class Select implements FileIO, ListMutator
  (@options = {}) ->
    @file = @options.select-file or @selected-file!
    @validate!
    @read!
    @content = @options.select or @content
    @

  selected-file: ->
    if @options.env then @env-file! else @select-file!

  select-file: ->
    gconf.location 'select.file'

  env-file: ->
    [gconf.dir, @options.env,  @select-file!].join '/'

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
    @installs = []
    for name in @list!
      @installed @registry!.install name
    @installs

  uninstall: (name) ->
    @registry!.uninstall name

  installed: (name) ->
    return unless name
    console.log 'installed:' + name
    @installs.push name
    name

  registry: (options) ->
    options ||= @options
    @_registry ||= new Registry options

  build: (cb, options) ->
    @install!
    @configurator(options).build cb

  configurator: (options) ->
    options ||= @options
    new Configurator options

  # cache lines!
  lines: ->
    @_lines ||= @content.split "\n" .filter( (x) -> !!x ).map( (x) -> x.trim! )

  list:->
    @lines!

  clear: ->
    @_lines = void

  index: (name) ->
    @lines!.index-of name
