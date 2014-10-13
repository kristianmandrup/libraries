/**
 * User: kristianmandrup
 * Date: 14/10/14
 * Time: 00:13
 */
FileIO          = require '../file-io'


module.exports = class Transferer implements FileIO
  (@env) ->
    @path = './xlibs'

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