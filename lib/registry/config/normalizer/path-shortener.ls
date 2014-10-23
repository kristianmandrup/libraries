is-blank = (str) ->
  !str or /^\s*$/.test str

module.exports = class PathShortener
  (@config, @root) ->

  shorten-paths: ->
    @shorten!
    @config

  shorten: ->
    if @root then @shorten-dir! else @shorten-file-paths!

  # can be reused at at lv with files
  shorten-dir: ->
    return if is-blank @root
    return unless typeof! @config.dir is 'String'
    @config.dir = @config.dir.slice (@root + '/').length
    @config

  # can be reused at at lv with files
  shorten-file-paths: ->
    short-files = []
    return unless typeof! @config.files is 'Array'
    for file in @config.files
      short-files.push @shorten-path file
    @config.files = short-files
    @config

  shorten-path: (file)->
    root = @config.dir || ''
    matches = file.match new RegExp "^(#{root}\/?)"
    if matches
      file = file.slice matches[1].length
    file
