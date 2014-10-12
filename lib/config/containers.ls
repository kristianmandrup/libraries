/**
 * User: kristianmandrup
 * Date: 11/10/14
 * Time: 09:47
 */
Container = require './container'

module.exports = class Containers
  (@container-objs, @config) ->

  containers: ->
    @_containers ||= Object.keys(@container-objs).map (name) ~>
      @container name

  # f.ex bower or vendor
  # TODO: cache?
  container: (name) ->
    new Container(@container-objs[name] or {}, @config)

  build: ->
    @_build ||= @containers!.map (container) ->
      container.build!