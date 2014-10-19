path = require 'path'

module.exports = class FileNormalizer
  (@file, @config) ->
    @normalized = @config or @own-normalized
    @validate!
    @

  validate: ->

  normalize: (file) ->
    file ||= @file
    @type = @find-type @extension-of(file), file
    if @type
      @add-file!
      @set-dir!

  extension-of: (file) ->
    file ||= @file
    path.extname(file).slice(1)

  find-type: (ext, file) ->
    file ||= @file
    for key, value of @types
      return key if value.index-of(ext) > -1
    console.error "Unknown file type: #{ext} for #{@file}"

  types:
    scripts: ['js', 'coffee', 'ls']
    styles: ['css', 'scss', 'less', 'sass']
    fonts:  ['eof', 'svg']
    images: ['jpg', 'png', 'gif', 'bmp']

  add-file: (type) ->
    type ||= @type
    entry = @normalized[type]
    entry.files ||= []
    entry.files.push @file
    @

  set-dir: (type) ->
    type ||= @type
    dir = path.dirname @file
    entry = @normalized[type]
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
