path = require 'path'

is-blank = (str) ->
  !str or /^\s*$/.test str

FileNormalizer     = require './file-normalizer'
RootPathNormalizer = require './root-path-normalizer'

module.exports = class FilesNormalizer
  (@config) ->
    @validate!
    @files = @config.files

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to normalize must be an Object, was: #{@config}"

  normalize: ->
    return @config unless @files
    for file in @files
      @file-normalizer!.normalize file

    @root-path-normalizer!.normalize!

  file-normalizer: ->
    new FileNormalizer @normalized

  root-path-normalizer: ->
    new RootPathNormalizer @normalized

  normalized:
    script: {}
    styles: {}
    fonts: {}





