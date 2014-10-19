PathShortener      = require './path-shortener'
path  = require 'path'

is-blank = (str) ->
  !str or /^\s*$/.test str

module.exports = class PathNormalizer
  (@config, @files) ->
    @validate!

  validate: ->
    unless typeof! @config is 'Object'
      throw Error "Config must be an Object, was #{@config}"

    unless typeof! @files is 'Array'
      throw Error "Must take a files array as 2nd argument, was: #{@files}"

  normalize: ->
    unless is-blank @root!
      @config.dir = @root!
      @path-shortener!.shorten-paths!

  root: ->
    @_root ||= @find-root-path path.dirname @files[0]

  # can be reused for script root etc
  find-root-path: (file-path, lv = 0, root) ->
    paths = file-path.split '/'
    path = paths[0 to lv].join '/'
    for file in @files
      return root unless file.match new RegExp "^#{path}"
    return @find-root-path file, lv+1, path

  path-shortener: ->
    new PathShortener @config

