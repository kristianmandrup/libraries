FileLoader      = require 'adater/file-loader'
JsonLoader      = require 'adater/json-loader'
CompositeLoader = require 'adater/composite-loader'

module.exports = class ConfigLoader
  (@type, ...@args) ->
    @type ||= 'all'
    @validate!

  validate: ->
    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

  adapter: ->
    new @selected-loader! ...@args

  selected-loader: ->
    switch @type
    when 'file'
      FileLoader
    when 'json'
      JsonLoader
    when 'composite'
      CompositeLoader
    else
      throw new Error "unknown Installer #{@type}"