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

  location-of: (paths, obj, d) ->
    paths = paths.split('.') if typeof! paths is 'String'
    path  = paths.shift!
    val = obj[path]
    if d and path isnt 'dir'
      dir = obj.dir
      val = [dir, val].join \/ if typeof! dir is 'String'
    return val if paths.length is 0 or typeof! val is 'String'
    @location-of paths, val, true

  location: (path) ->
    loc = [@rc-json!.dir]
    path = @location-of path, @rc-json!
    loc = loc.concat path
    loc = loc.join '/'

  load-rc: ->
    @read @librariesrc

  select: ->
    file: ~>
      @location 'select.file'

  builds: ->
    dir: ~>
      @location 'builds.dir' # or @default!.builds!.dir!

  components: ->
    dir: ~>
      @location 'components.dir' # @default!.components!.dir!

    file: ~>
      @location 'components.file'
      # @default!.components!.file!

  config: ->
    file: ~>
      @location 'config.file'
      # @rc-json!.config.file or @default!.config!.file

  registries: ->

    @parse-registries @location 'components.file' # @default!.registries

  parse-registries: (regs) ->
    regs

  default: ->
    dir: './xlibs/'
    builds: ->
      dir: ~>
        console.log 'ctx', @
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