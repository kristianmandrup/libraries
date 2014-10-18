module.exports = class Github
  ->
    @host   = 'https://raw.githubusercontent.com'
    @branch = 'master'
    @folder = 'registry'
    @

  registry-path: (repo = 'kristianmandrup/libraries') ->
    [@host, repo, @branch, @folder].join '/'
