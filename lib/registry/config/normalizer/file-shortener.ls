module.exports = class FileShortener
  (@config) ->

  # can be reused at at lv with files
  shorten-files: ->
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
