util = require 'util'

module.exports = class GithubRepoTranslator
  (@repo-uri) ->
    @validate!
    @

  validate: ->
    unless typeof! @repo-uri is 'String'
      throw new Error "repo-uri uri to translate must be a String, was: #{util.inspect @repo-uri}"

  extract-repo: ->
    @matches ||= @repo-uri.match /github.com\/(.*)\/(.*)\./

  repo-account: ->
    @extract-repo!.1

  repo-name: ->
    @extract-repo!.2

  translate: ->
    "https://raw.githubusercontent.com/#{@repo-account!}/#{@repo-name!}/master/bower.json"