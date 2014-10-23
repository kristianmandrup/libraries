module.exports = class PathShortener
  (@config) ->
    console.log 'config', config

  shorten-paths: ->
    for key of @config
      @shorten-paths-for key, @config[key]
    @config

  # can be reused at at lv with files
  shorten-paths-for: (key, entry) ->
    short-files = []
    return unless typeof! entry is 'Object' and typeof! entry.files is 'Array'
    console.log 'entry', key, entry, @config
    for file in entry.files
      short-files.push @shorten-path(file)
    @config[key].files = short-files
    @config[key]

  shorten-path: (file)->
    root = @config.dir || ''
    matches = file.match new RegExp "^(#{root}\/?)"
    if matches
      file = file.slice matches[1].length
    file
