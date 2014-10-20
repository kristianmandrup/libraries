fs              = require 'fs-extra'
jsonlint        = require 'jsonlint'
FileIO          = require '../../../util/file-io'
BaseInstaller   = require './base-installer'

module.exports = class FileInstaller extends BaseInstaller implements FileIO
  (@name, @content, @options = {}) ->
    super ...

  validate: ->
    super!
    unless typeof! @content is 'String'
      throw new Error "Source of config must be a String, was: #{@content}"


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

