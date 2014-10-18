module.exports = class FileNormalizer
  (@file) ->

  normalize: (file) ->
    ext = path.extname file
    @type = @find-type ext, file
    if @type
      @add-file!
      @set-dir!

  find-type: ->
    for key, value of @types
      return key if value.index-of(@type) > -1
    console.error "Unknown file type: #{@type} for #{@file}"

  types:
    script: ['js', 'coffee', 'ls']
    styles: ['css', 'scss', 'less', 'sass']
    fonts:  ['eof', 'svg']

  add-file: ->
    entry = normalized[@type]
    entry.files ||= []
    entry.files.push @file

  set-dir: ->
    dir = path.dirname @file
    entry = normalized[@type]
    current = entry.dir
    if current is void
      entry.dir = dir
    if current isnt dir
      entry.dir = ''