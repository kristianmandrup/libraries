path = require 'path'

module.exports = class FileNormalizer
  (@config, @file) ->
    @normalized = @config or @own-normalized
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
      # @set-dir!
    @normalized

  extension: (file) ->
    @file ||= file
    path.extname(@file).slice(1)

  find-type: (ext, file) ->
    @file ||= file
    @ext  ||= ext
    for key, value of @types
      return key if value.index-of(@ext) > -1
    console.error "Unknown file type: #{@ext} for #{@file}"

  types:
    scripts: ['js', 'coffee', 'ls']
    styles: ['css', 'scss', 'less', 'sass']
    fonts:  ['eof', 'svg']
    images: ['jpg', 'png', 'gif', 'bmp']

  add-file: (type) ->
    @type ||= type
    entry = @normalized[@type]
    entry.files ||= []
    entry.files.push @file unless entry.files.index-of(@file) > -1
    @

  set-dir: (type) ->
    @type ||= type
    dir = path.dirname @file
    entry = @normalized[@type]
    if entry.dir is void
      entry.dir = dir
    if entry.dir isnt dir
      entry.dir = ''
    @

  own-normalized:
    main: {}
    scripts: {}
    styles: {}
    fonts: {}
    images: {}
    files: {}
