# loads global config from .librariesrc

FileIO      = require './util/file-io'
fs          = require 'fs-extra'
jsonlint    = require 'jsonlint'

module.exports = class GlobalConfig implements FileIO
  (@options) ->
    @librariesrc = './.librariesrc'
    @

  rc-json: ->
    @_rc-json ||= jsonlint.parse @load-rc!

  default-location-of: (paths) ->
    @location-of paths, @default!, true

  location-of: (paths, obj, d) ->
    paths = paths.split('.') if typeof! paths is 'String'
    path  = paths.shift!
    val = obj[path]
    val = val! if typeof! val is 'Function'
    if d and path isnt 'dir'
      dir = obj.dir
      dir = dir! if typeof! dir is 'Function'
      val = path if typeof! val isnt 'String'
      val = [dir, val].join \/ if typeof! dir is 'String'
    return val if paths.length is 0 or typeof! val is 'String'
    @location-of paths, val, true

  find-location-of: (path, obj) ->
    @location-of(path, @rc-json!) or @default-location-of(path)

  location: (path) ->
    loc = [@rc-json!.dir]
    path = @find-location-of path, @rc-json!
    loc = loc.concat path
    loc = loc.join '/'

  load-rc: ->
    @read @librariesrc

  select: ->
    file: ~>
      @location 'select.file'

  builds: ->
    dir: ~>
      @location 'builds.dir'

  components: ->
    dir: ~>
      @location 'components.dir'

    file: ~>
      @location 'components.file'

  config: ->
    file: ~>
      @location 'config.file'

  registries: ->
    @parse-registries @location 'registries'

  parse-registries: (regs) ->
    regs

  default: ->
    dir: './xlibs'
    builds: ->
      dir: ~>
        [@dir, 'builds'].join '/'
    components: ->
      dir: ~>
        [@dir, 'components'].join '/'
      file: ->
        [@dir, 'index.json'].join '/'
    select: ->
      file: ~>
        [@dir, 'select'].join '/'
    config: ->
      file: ~>
        [@dir, 'config.json'].join '/'
    registries: [
      {name: 'libraries-official', type: 'uri', repo: 'kristianmandrup/libraries'}
    ]