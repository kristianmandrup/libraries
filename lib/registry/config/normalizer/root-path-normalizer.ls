PathShortener      = require './path-shortener'

module.export = class RootPathNormalizer
  (@config) ->

  normalize: ->
    root = @find-root-path path.dirname file[0]
    unless is-blank root
      @config.dir = root
      @path-shortener!.shorten-paths!

  # can be reused for script root etc
  find-root-path: (file-path, lv = 0, root) ->
    paths = file-path.split('/')
    match-path = paths[0 to lv].join '/'
    for file in @files
      return root unless match-path.match /^#{path}/
    return @find-root-path file, lv+1, match-path

  path-shortener: ->
    new PathShortener @config

