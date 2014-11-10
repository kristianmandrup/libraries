FileIO          = require '../util/file-io'

GlobalConfig  = require '../global-config'
gconf         = new GlobalConfig

module.exports = class Transferer implements FileIO
  (@env) ->
    @path = gconf.dir!

  transfer: ->
    @copy-select!
    @copy-config!

  copy-select: (env) ->
    env ||= @env
    try
      fs.copySync @selected(env), @selected(@target env)
    catch err
      @error err
      void

  copy-config: (env) ->
    env ||= @env
    try
      fs.copySync @config(env), @config(@target env)
    catch err
      @error err
      void

  target: (env) ->
    switch env
    case 'dev' then 'test'
    case 'test' then 'prod'
    default 'prod'

  selected: (env) ->
    [@path, env, 'selected'].join '/'

  config: (env) ->
    [@path, env, 'config'].join '/'