path  = require 'path'

module.exports = class RootPath
  (@files) ->
    @validate!

  validate: ->
    unless typeof! @files is 'Array'
      throw Error "Files must be an Array, was: #{@files}"

  find: ->
    @_root ||= @find-root-path path.dirname @files[0]

  # can be reused for script root etc
  find-root-path: (file-path, lv = 0, root) ->
    paths = file-path.split '/'
    path = paths[0 to lv].join '/'
    for file in @files
      return root unless file.match new RegExp "^#{path}"
    return @find-root-path file, lv+1, path
