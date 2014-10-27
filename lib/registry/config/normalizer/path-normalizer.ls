PathShortener      = require './path-shortener'
RootPath           = require './root-path'

is-blank = (str) ->
  !str or /^\s*$/.test str

module.exports = class PathNormalizer
  (@config, @files) ->
    @files ||= @config.files
    @validate!

  validate: ->
    unless typeof! @config is 'Object'
      throw Error "Config must be an Object, was #{@config}"

    unless typeof! @files is 'Array'
      throw Error "Must take a files array as 2nd argument, was: #{@files}"

  # iterate keys with files entry
  # find root of each and set as dir
  # now iterate dirs, find root of common dir and set as top lv dir
  normalize: ->
    @normalize-key-files!
    @normalize-key-dirs!
    @config

  set-root: ->
    root = @root-path-of(@dirs!).find!
    if typeof! root is 'String'
      @root = root

    unless is-blank @root
      @config.dir = @root

  dirs: ->
    dirs = []
    for key in @config-keys!
      dirs.push @config[key].dir
    dirs

  config-keys: ->
    return [] unless @config.scripts
    Object.keys @config

  normalize-key-files: ->
    for key in @config-keys!
      @normalize-files-for key, @config[key]

  normalize-key-dirs: ->
    @set-root!
    for key in @config-keys!
      @normalize-dir-for key, @config[key]

  normalize-files-for: (key, config) ->
    return if key is 'dir'
    return unless config.files

    root = @root-path-of(config.files).find!
    unless is-blank root
      config.dir = root
      @config[key] = @path-shortener(config).shorten-files!

  normalize-dir-for: (key, config) ->
    return if key is 'dir'
    return unless config.dir
    @config[key] = @path-shortener(config).shorten-dir @root

  root-path-of: (files) ->
    new RootPath files

  path-shortener: (config, root) ->
    config ||= @config
    new PathShortener config, root

