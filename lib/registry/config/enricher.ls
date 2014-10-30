PkgAdapter = require './package/pkg-adapter'

module.exports = class Enricher
  (@config, @options = {}) ->
    @name = @options.name
    @type = @options.type or 'bower'
    @validate!
    @

  validate: ->
    console.log 'options', @options
    unless typeof! @name is 'String'
      throw new Error "Name must be a String, was: #{@name}"

    unless typeof! @type is 'String'
      throw new Error "Type must be a String, was: #{@type}"

    unless typeof! @config is 'Object'
      throw new Error "Config must be an Object, was: #{@config}"

  enrich: ->
    @adapt!then (res) ~>
      @config <<< res
      @config

  adapted: ->
    @_adapted or {}

  adapt: ->
    @_adapted ||= @pkg-adapter!.adapt!

  pkg-adapter: ->
    new PkgAdapter @options


