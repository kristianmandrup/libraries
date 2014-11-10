FileInstaller     = require './installer/file-installer'
JsonInstaller     = require './installer/json-installer'

module.exports = class Installer
  (@type, ...@args) ->
    @type ||= 'file'
    @validate!

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  install: (name, opts = {}) ->
    unless typeof name is 'string'
      throw Error "Must have a name of component to install, was: #{name}"

    unless opts.source
      throw Error "Missing source to install from, was: #{opts}"

    @installer!install name, opts.source, opts

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
