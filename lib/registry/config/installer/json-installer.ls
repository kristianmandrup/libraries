FileIO          = require '../../../util/file-io'
BaseInstaller   = require './base-installer'
fs              = require 'fs-extra'
util            = require 'util'

is-blank = (str) ->
    !str or /^\s*$/.test str

module.exports = class JsonInstaller extends BaseInstaller implements FileIO
  (@name, @source, @options = {}) ->
    @file = @options.file || './xlibs/components.json'
    super ...
    @convert!
    @validate!
    @content = void

  convert: ->
    if is-blank @source
     throw new Error "Source must be an Object or a JSON string, was: #{util.inspect @source}"
    if typeof! @source is 'String'
      try
        @source = @jsonlint @source
      catch e
        @error "Can't convert source to valid JSON", e
        throw new Error "Can't convert source to valid JSON"

  components: ->
    @json!

  stringified: ->
    JSON.stringify @components!, null, 4

  install: (force)->
    return void if @components![@name] and not force
    try
      @installing!
      @components![@name] = @source
      @content = @stringified!
      @write-file!
      true
    catch err
      @error err
      void

  uninstall: ->
    try
      delete @components![@name] if @components![@name]
      @content = @stringified!
      @write-file!
      true
    catch err
      @error err

