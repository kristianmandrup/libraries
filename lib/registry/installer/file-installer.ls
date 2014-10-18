fs              = require 'fs-extra'
jsonlint        = require 'jsonlint'
FileIO          = require '../../file-io'
BaseInstaller   = require './base-installer'

module.exports = class FileInstaller extends BaseInstaller implements FileIO
  (@name, @content, @file, @options = {}) ->
    super ...

  install: ->
    return void if @exists @file
    try
      @installing
      @write-file!
      return @name
    catch err
      @error err
      void

  uninstall: ->
    try
      @uninstalling
      @remove-file!
    catch err
      @error err

