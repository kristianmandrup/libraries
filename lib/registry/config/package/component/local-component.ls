# knows how to search for a component and convert into a normalized library component config

co      = require 'co'
search  = co(require 'component-search2')

warning = (msg) ->
  throw Error msg

registry =
  search: (query, cb) ->
    location = ['./components', query.name, 'component.json']
    fs.readFile location, (err, pkg) ->
      cb err if err
      cb 'no matching components found' if !pkgs.length
      cb null, [jsonlint.parse pkg ]

Q = require 'q'

BaseComponentAdapter  = require './base-component'

module.exports = class LocalComponentAdapter extends BaseComponentAdapter
  (@name, @options = {}) ->
    super ...

  query: ->
    @_query ||=
      name: @name


