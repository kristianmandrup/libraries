Q = require 'q'

module.exports = class BaseComponentAdapter
  (@name, @options = {}) ->
    @validate!
    @repos.push @options.repo if @options.repo
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of bower component must be a String, was: #{util.inspect @name}"

  adapted:
    main: {}
    scripts: {}
    styles: {}
    fonts: {}
    images: {}
    files: {}

  configure: (pkg) ->
    for key of @adapted
      @adapted[key].files = pkg[key] if pkg[key]

  retrieve: ->
    @find!.promise.then (pkgs) ~>
      @configure pkgs[0]

  # https://github.com/componentjs/search.js/blob/master/node/search.js
  # https://github.com/componentjs/search.js/blob/master/client/search.js
  find: ->
    deferred = Q.defer!
    registry.search @query!, deferred.make-node-resolver!
    deferred
