Selector      = require './select/selector'
Configurator  = require './config/configurator'
Registry      = require './registry/registry'
Generator     = require './output/generator'
ConfigLoader  = require './registry/config-loader'
Transferer    = require './transferer/transferer'

fs    = require 'fs-extra'
path  = require 'path'

module.exports =
  select: (opts = {}) ->
    @_selector ||= new Selector opts or @options

  setup: ->
    xlibs-src = path.resolve __dirname, 'setup/xlibs'
    fs.copy xlibs-src, '.', (err) ->
      return console.error(err) if err

  add: (opts = {}) ->
    @config(opts).add opts

  remove: (opts = {}) ->
    @config(opts).remove opts

  config: (opts = {}) ->
    @_config ||= new Configurator opts or @options

  registry: (opts = {}) ->
    new Registry opts || @options

  generator: (opts = {}) ->
    @_generator ||= new Generator opts or @options

  config-loader: (name, path) ->
    @_config-loader ||= new ConfigLoader name, path

  transferer: -> (env) ->
    @_transferer ||= new Transferer env

  success: ->
    console.log chalk.green('success ;>)')

  install: (opts) ->
    console.log 'installing...'
    @select(opts).install!
    @success!

  transfer: (env = 'dev') ->
    @transferer.transfer env

  uninstall: (name, opts) ->
    @registry(opts).uninstall name
    @success!

  load-applier: (opts = {}) ->
    @generator(opts).load!

  # you can call with custom callback function to control
  # what to emit from build ;)
  # if not passed, it will use a default emit for Broccoli
  build: (opts) ->
    console.log 'building...', @config
    @install opts
    cb = opts.cb if opts
    build = @select(opts).build cb
    @generator(opts).generate build
    @success!
