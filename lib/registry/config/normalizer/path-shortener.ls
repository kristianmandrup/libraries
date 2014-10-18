module.exports = class PathShortener
  (@config) ->

  shorten-paths: ->
    for key of @config
      shorten-paths-for @config[key]

  # can be reused at at lv with files
  shorten-paths-for: (entry) ->
    shortened-files = []
    for file in entry.files
      shortened.push @shorten-path(file)
    @config[key].files = shortened-files

  shorten-path: (file)->
    file.slice(@config.root.length)
