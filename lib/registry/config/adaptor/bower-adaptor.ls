# knows how to read a bower.json file and convert into a normalized library component config

FileIO          = require '../../../file-io'

RegistryClient = require 'bower-registry-client'

registry       = new RegistryClient strictSsl: false, timeout: 5000
search         = registry.lookup

# console.log 'config', registry._config
# console.log 'search', search

sync-request = require 'sync-request'

fs              = require 'fs-extra'
util            = require 'util'

Q = require 'q'

is-blank = (str) ->
    !str or /^\s*$/.test str

module.exports = class BowerAdapter implements FileIO
  (@name, @options = {}) ->
    @validate!
    @repos.push @options.repo if @options.repo
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of bower component must be a String, was: #{util.inspect @name}"

  adapt: ->
    main: @main!
    files: @files[1 to -1]

  main: ->
    @files!.0

  files: ->
    if @has-main! then @main-files! else []

  has-main: ->
    !!@main-files!

  main-files: ->
    @bower-json!.main

  bower-json: ->
    @bower ||= jsonlint @retrieve!

  retrieve: ->
    @extract-repo!
    @retrieved ||= sync-request('GET', @repo-uri!).get-body!

  repo-translator: ->
    new GithubRepoTranslator @repo!

  repo-uri: ->
    @repo-translator!.translate!

  repos: []

  # for now just use first repo
  repo: ->
    @find-repos! if @repos!.length is 0
    @repos.0

  find-repos: ->
    find (repos) ->
      @repos.push repos

  find: ->
    deferred = Q.defer!
    registry.lookup @name, deferred.make-node-resolver!
    deferred
