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

  load-rc: ->
    @read @librariesrc

  select:
    file: ~>
      @rc-json!.select.file or @default.select!.file!

  builds: ->
    dir: ~>
      @rc-json!.builds.dir or @default.builds!.dir!

  components: ->
    dir: ~>
      @rc-json!.components.dir or @default.components!.dir!

    file: ~>
      @rc-json!.components.file or @default.components!.file!

  config: ->
    file: ~>
      @rc-json!.config.file or @default.config!.file

  registries: ->
    @parse-registries @rc-json!.registries or @default.registries

  parse-registries: (regs) ->
    regs

  default: ->
    dir: './xlibs/'
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