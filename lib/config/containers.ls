Container = require './container'
util = require 'util'

module.exports = class Containers
  (@container-objs, @config) ->
    @validate!
    @

  validate: ->
    unless typeof! @container-objs is 'Object'
      throw new Error "Container objects must be an Object, was: #{util.inspect @container-objs}"

    unless typeof! @config is 'Object'
      throw new Error "Config must be an Object, was: #{util.inspect @config}"

  all: ->
    @_all ||= Object.keys(@container-objs).map (name) ~>
      @container name

  # f.ex bower or vendor
  container: (name) ->
    new Container(@container-objs[name] or {}, @config)

  # always install before build!
  build: ->
    @install!
    @all!.map (container) ->
      container.build!

  install: ->
    @all!.map (container) ->
      container.install!
