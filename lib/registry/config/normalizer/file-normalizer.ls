path = require 'path'

module.exports = class FileNormalizer
  (@config, @file) ->
    @normalized = @config or {}
    @validate!
    @

  validate: ->
    if @file and typeof! @file isnt 'String'
      throw Error "File must be a String, was: #{@file}"

    unless typeof! @config is 'Object'
      throw Error "Config must be an Object, was: #{@file}"

  normalize: (file) ->
    @file ||= file
    @ext = @extension!
    @type = @find-type!
    if @type
      @add-file!
    @normalized

  extension: (file) ->
    @file ||= file
    path.extname(@file).slice(1)

  find-type: (ext, file) ->
    @file ||= file
    @ext  ||= ext
    for key, value of @types
      return key if value.index-of(@ext) > -1
    # put in files if unknown extension
    \files

  # TODO: make optionally configurable from global conf
  types:
    scripts: ['js', 'coffee', 'ls']
    styles: ['css', 'less', 'scss', 'sass']
    fonts:  ['eot', 'svg', 'ttf', 'woff']
    images: ['jpg', 'png', 'gif', 'bmp']

  add-file: (type) ->
    @type ||= type
    entry = @normalized[@type] ||= {}
    entry.files ||= []
    entry.files.push @file unless entry.files.index-of(@file) > -1
    @

