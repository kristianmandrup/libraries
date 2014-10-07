/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:40
 */

Component = require './component'
ListMutator   = require '../list-mutator'

module.exports = class Components implements ListMutator
  (@list) ->

  validate: ->
    unless typeof! @libs is 'Array'
      throw new Error "Must be an Array"

  component: (name) ->
    new Component name

  add-one: (name) ->
    @list.push name
    @

  remove-one: (name) ->
    @_remove-item @list, name
    @

  index: (name) ->
    @list.index-of name
