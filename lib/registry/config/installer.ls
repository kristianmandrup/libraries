FileInstaller     = require './installer/file-installer'
JsonInstaller     = require './installer/json-installer'

module.exports = class Installer
  (@type, ...@args) ->
    @type ||= 'file'
    @validate!

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  installer: ->
    clazz = @selected-installer!
    new clazz ...@args

  selected-installer: ->
    @installers[@type] or @bad-installer!

  bad-installer: ->
    @error "Installer #{@type} has not been registered"

  error: (msg) ->
    console.error msg
    throw new Error msg

  installers:
    file: FileInstaller
    json: JsonInstaller
