FileInstaller     = require './installer/file-installer'
JsonInstaller     = require './installer/json-installer'

module.exports = class Installer
  (@type, ...@args) ->
    @type ||= 'file'
    @validate!

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  adapter: ->
    new @selected-installer! ...@args

  select-adapter: ->
    switch @type
    when 'file'
      FileInstaller
    when 'json'
      JsonInstaller
    else
      throw new Error "unknown Installer #{@type}"