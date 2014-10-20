# knows how to read a bower.json file and convert into a normalized library component config

FileIO          = require '../../../../util/file-io'

RegistryClient = require 'bower-registry-client'

registry       = new RegistryClient strictSsl: false, timeout: 12000
search         = registry.lookup

sync-request = require 'sync-request'
retrieve     = require '../../../../util/remote' .retrieve

fs              = require 'fs-extra'
util            = require 'util'
jsonlint        = require 'jsonlint'

Q = require 'q'

is-blank = (str) ->
    !str or /^\s*$/.test str

escape-reg-exp = (str) ->
  str.replace /([.*+?^${}()|\[\]\/\\])/g, "\\$1"

GithubRepoTranslator  = require './github-repo-translator'
BaseBowerAdapter      = require './base-bower'

logx = (msg) ->
  console.log util.inspect(msg)

module.exports = class RemoteBowerAdapter extends BaseBowerAdapter
  (@name, @options = {}) ->
    super ...

  # Async
  retrieve: ->
    @repo-uri!.then (uri) ~>
      @retrieve-body uri

  retrieve-body: (uri) ->
    deferred = Q.defer!
    retrieve uri, deferred.make-node-resolver!
    deferred.promise.then (body) ~>
      body

  # Sync
  retrieve-sync: ->
    @repo-uri!.then (uri) ~>
      @retrieved ||= sync-request('GET', uri).get-body!

  repo-translator: (repo) ->
    new GithubRepoTranslator repo

  repo-uri: ->
    @repo!.then (repo) ~>
      @_repo = repo
      @repo-translator(repo).translate!

  repos: []

  # for now just use first repo
  repo: ->
    @find-repos (repos) ->
      if repos.length is 0 then @repos.0 else repos.0

  filtered: ->
    @_filtered ||= @found-repos.filter (repo) ~>
      name = escape-reg-exp @name
      repo.match new RegExp "#{name}.git$"

  find-repos: (cb) ->
    @find!.promise.then (found-repos) ~>
      @found-repos = @map found-repos
      cb @filtered!

  map: (repos) ->
    switch typeof! repos
    when 'Object'
      [repos.url]
    when 'Array'
      repos.map (repo) ~>
        @map repo

  find: ->
    deferred = Q.defer!
    registry.lookup @name, deferred.make-node-resolver!
    deferred
