PathShortener      = require './path-shortener'
RootPath           = require './root-path'

is-blank = (str) ->
  !str or /^\s*$/.test str

module.exports = class PathNormalizer
  (@config, @files) ->
    console.log 'config', config
    @files ||= @config.files
    @validate!

  validate: ->
    unless typeof! @config is 'Object'
      throw Error "Config must be an Object, was #{@config}"

    unless typeof! @files is 'Array'
      throw Error "Must take a files array as 2nd argument, was: #{@files}"

  normalize: ->
    @root = @root-path-of @files
    unless is-blank @root
      @config.dir = @root
      @path-shortener(@config).shorten-paths!

    for key in @config-keys!
      @normalize-for(key)
    @config

  config-keys: ->
    return [] unless @config.scripts
    Object.keys @config

  normalize-for: (key) ->
    return unless @config[key].files and key isnt 'dir'
    console.log 'normalize', key, @config[key]
    new PathNormalizer @config[key] .normalize!

  root-path-of: (files) ->
    new RootPath files

  path-shortener: (config) ->
    config ||= @config
    new PathShortener @config

