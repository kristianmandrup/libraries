is-blank = (str) ->
  !str or /^\s*$/.test str

module.exports = class PathShortener
  (@config) ->

  # can be reused at at lv with files
  shorten-dir: (@root) ->
    return @config if is-blank @root
    return unless typeof! @config.dir is 'String'
    @config.dir = @config.dir.slice (@root + '/').length
    @config
