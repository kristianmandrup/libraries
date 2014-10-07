/**
 * User: kristianmandrup
 * Date: 07/10/14
 * Time: 23:07
 */
module.exports =
  add: (names) ->
    names = @_normalize names
    for name in names
      @add-one name
    @

  remove: (names) ->
    names = @_normalize names
    for name in names
      @remove-one name
    @

  _normalize: (names) ->
    if typeof! names is 'String' then [names] else names

  _remove-item: (list, name) ->
    return @ unless @has name
    list.splice @index(name), 1

  has: (name) ->
    @index(name) > -1
