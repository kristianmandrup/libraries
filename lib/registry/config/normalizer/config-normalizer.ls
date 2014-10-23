path = require 'path'

is-blank = (str) ->
  !str or /^\s*$/.test str

FileNormalizer     = require './file-normalizer'
PathNormalizer = require './path-normalizer'

module.exports = class ConfigNormalizer
  (@config) ->
    @validate!
    @files = @config.files
    @

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to normalize must be an Object, was: #{@config}"

  normalize: ->
    return @config unless @files
    for file in @files
      @file-normalizer!.normalize file

    @path-normalizer!.normalize!

  file-normalizer: ->
    new FileNormalizer @normalized

  path-normalizer: ->
    new PathNormalizer @normalized, @files

  normalized:
    main: {}
    scripts: {}
    styles: {}
    fonts: {}
    images: {}
    files: {}




