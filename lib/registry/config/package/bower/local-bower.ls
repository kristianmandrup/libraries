# local bower adaptor

BaseBowerAdapter  = require './base-bower'

GlobalConfig  = require '../../../../global-config'
gconf         = new GlobalConfig

module.exports = class LocalBowerAdapter extends BaseBowerAdapter
  (@name, @options = {}) ->
    super ...

  repo-uri: ->
    [@repo-path!, 'bower.json'].join '/'

  repo-path: ->
    [gconf.bower!.dir!, @name].join '/'

  retrieve-body: (uri) ->
    deferred = Q.defer!
    fs.readFile uri, deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body
