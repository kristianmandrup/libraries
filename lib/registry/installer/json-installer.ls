fs              = require 'fs-extra'
FileIO          = require '../../file-io'
BaseInstaller   = require './base-installer'

module.exports = class JsonInstaller extends BaseInstaller implements FileIO
  (@name, @source, @file, @options = {}) ->
    @convert!
    @validate!

  convert: ->
    if typeof! @source is 'String'
      @source = @jsonlint @source

  components: ->
    @json!.components

  stringified: ->
    JSON.stringify @source

  install: ->
    return void if @components![@name]
    try
      @installing!
      @components![@name] = @source
      @content = @stringified!
      @write-file!
      return name
    catch err
      @error err
      void

  uninstall-file: ->
    try
      @uninstalling name
      fs.unlinkSync @file
    catch err
      @error err

  uninstall-file: ->
    try
      delete @components![@name] if @components![@name]
      @write-file!
    catch err
      @error err

