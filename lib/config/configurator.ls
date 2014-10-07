FileIO      = require '../file-io'
Components  = require '../component/components'

module.exports = class Configurator implements FileIO
  (@file) ->
    @file ||= './xlibs/config.json'
    @validate!
    @read!
    @config = @json!.config or {}
    @

  cmps: ->
    @_cmps ||= new Components @

  validate: ->
    unless @exists!
      throw new Error "File #{@file} does not exist"

  # f.ex bower or vendor
  part: (name) ->
    @json![name] or {}

  components: (name) ->
    @part(name).components or []

  libs: (name) ->
    @part(name).libs or {}
