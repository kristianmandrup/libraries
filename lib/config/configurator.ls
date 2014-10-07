FileIO = require '../file-io'

module.exports = class Configurator implements FileIO
  (@file) ->
    @file ||= './xlibs/config.json'
    @validate!
    @read!
    @config = @json!.config or {}
    @

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
