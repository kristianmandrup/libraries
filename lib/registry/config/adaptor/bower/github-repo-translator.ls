module.exports = class GithubRepoTranslator
  (@repo) ->

  extract-repo: ->
    @matches ||= @repo!.match /github.com\/(.*)\/(.*)\./

  repo-account: ->
    @matches.0

  repo-name: ->
    @matches.1

  translate: ->
    @extract-repo!
    "https://raw.githubusercontent.com/#{@repo-account!}/#{@repo-name!}/master/bower.json"