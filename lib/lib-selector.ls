/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 13:56
 */
module.exports = class LibSelector
  (@file) ->
    @file ||= './xlibs/lib-select.json'
    @

  select: ->
    @content.select or []

  add: (name) ->
    @content.select = @select!.push name
    # do some magic!
    @

  remove: (name) ->
    index = @select!.index-of name
    @content.select = @select!.splice index, 1
    # do some magic!
    @