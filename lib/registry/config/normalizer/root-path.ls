path  = require 'path'

module.exports = class RootPath
  (@files) ->
    @validate!

  validate: ->
    unless typeof! @files is 'Array'
      throw Error "Files must be an Array, was: #{@files}"

  find: (file) ->
    file ||= @files[0]
    root = @find-root-path path.dirname file
    if root is '.' then void else root

  # can be reused for script root etc
  #  dist/js/bootstrap.js
  #  [dist, js, bootstrap.js]
  #  dist
  #  compare dist with all files
  #  return if root if any one file doesnt share the same root path
  #  recurse, using same filepath, one higher lv, and current root
  find-root-path: (file-path, lv = 0, root) ->
    paths = file-path.split '/'
    path = paths[0 to lv].join '/'
    # console.log paths, path, root, lv
    return root if lv >= paths.length

    for file in @files
      return root unless file.match new RegExp "^#{path}"

    return @find-root-path file-path, lv+1, path

