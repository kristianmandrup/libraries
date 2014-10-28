# local bower adaptor

BaseBowerAdapter  = require './base-bower'

GlobalConfig  = require '../../../../global-config'
gconf         = new GlobalConfig

fs              = require 'fs-extra'
util            = require 'util'
Q               = require 'q'

module.exports = class LocalBowerAdapter extends BaseBowerAdapter
  (@name, @options = {}) ->
    super ...

  repo-uri: ->
    [@repo-path!, 'bower.json'].join '/'

  repo-path: ->
    [@bower-dir!, @name].join '/'

  bower-dir: ->
    gconf.dir-for 'bower'

  retrieve-body: (uri) ->
    deferred = Q.defer!
    fs.readFile uri, 'utf-8', deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body
