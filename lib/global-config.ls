# loads global config from .librariesrc

FileIO      = require './util/file-io'
fs          = require 'fs-extra'
jsonlint    = require 'jsonlint'

module.exports = class GlobalConfig implements FileIO
  (@options) ->
    @librariesrc = './.librariesrc'
    @

  dir-for: (type) ->
    @bower-dir(type) or @components-dir(type) or @npm-dir(type) or @unknown-dir type

  bower-dir: (type) ->
    @configured-bower-dir! if type is 'bower'

  # TODO: read config as for bower
  components-dir: (type) ->
    'components' if type is 'component'

  # TODO: read config as for bower
  npm-dir: (type) ->
    'node_modules' if type is 'npm'

  unknown-dir: (type) ->
    throw Error "Unknown package type: #{type}"

  # read .bowerrc for configured directory key if present
  configured-bower-dir: ->
    return @json('.bowerrc').directory if @exists '.bowerrc'
    'bower_components'

  rc-json: ->
    @_rc-json ||= jsonlint.parse @load-rc!

  default-location-of: (paths) ->
    @location-of paths, @default!, true

  location-of: (paths, obj, d) ->
    paths = paths.split('.') if typeof! paths is 'String'
    return void if paths is void
    path  = paths.shift!
    return void unless obj
    val = obj[path]
    val = val! if typeof! val is 'Function'
    if d and path isnt 'dir'
      dir = obj.dir
      dir = dir! if typeof! dir is 'Function'
      val = path if typeof! val isnt 'String'
      val = [dir, val].join \/ if typeof! dir is 'String'
    return val if paths.length is 0 or typeof! val is 'String'
    @location-of paths, val, true

  location: (path) ->
    loc-path = @location-of path, @rc-json!
    console.log path, loc-path
    if loc-path
      loc = [@rc-json!.dir]
      loc = loc.concat loc-path
      return loc.join '/'

    @default-location-of path

  find: (obj, path) ->
    paths = path.split('.') if typeof! path is 'String'
    return void if paths is void
    path  = paths.shift!
    return void unless obj
    val = obj[path]
    val = val! if typeof! val is 'Function'
    return val if paths.length is 0
    @find val, paths

  load-rc: ->
    @read @librariesrc

  get: (path )->
    @find(@rc-json!, path) or @find(@default!, path)

  preferences: ->
    @get 'preferences'

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
    registry: ->
      dir: ~>
        [@dir, 'registry'].join '/'

    registries: [
      {name: 'libraries-official', type: 'uri', repo: 'kristianmandrup/libraries'}
    ]

    preferences:
      styles:   ["scss", "sass", "less", "css"]
      scripts:  ["js", "min.js"]
