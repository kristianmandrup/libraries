# loads global config from .librariesrc

jsonlint = require 'jsonlint'

module.exports = class GlobalConfig
  (@options) ->
    @librariesrc = './.librariesrc'

  rc-json: ->
    @_rc-json ||= jsonlint.parse @load-rc!

  load-rc: ->
    @rc ||= fs.read-file-sync @librariesrc, 'utf-8'

  components-dir: ->
    @rc-json!.components-dir or @default.components.dir

  default:
    dir: './xlibs/'
    builds:
      dir: ~>
        [@dir, 'builds'].join '/'
    components:
      dir: ~>
        [@dir, 'components'].join '/'
      file: ->
        [@dir, 'index.json'].join '/'
    selected:
      file: ~>
        [@dir, 'selected'].join '/'
    config: ~>
      [@dir, 'config.json'].join '/'
    registries: [
      {'libraries-official': {type: 'uri', repo: 'kristianmandrup/libraries'}}
    ]


  components-file: ->
    @rc-json!.components-file or @default.components.file

  config-file: ->
    @rc-json!.config-file or @default.config.file

  registries: ->
    parse-registries @rc-json!.registries or @default.registries

  parse-registries: (regs) ->
    regs
