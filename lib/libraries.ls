Selector      = require './select/selector'
Configurator  = require './config/configurator'
Registry      = require './registry/registry'
Generator     = require './output/generator'

module.exports =
  select: (opts = {}) ->
    @_selector ||= new Selector opts or @options

  config: (opts = {}) ->
    @_config ||= new Configurator opts or @options

  registry: (opts = {}) ->
    new Registry opts || @options

  generator: (opts = {}) ->
    @_generator ||= new Generator opts or @options

  success: ->
    console.log chalk.green('success ;>)')

  install: (opts) ->
    console.log 'installing...'
    @select(opts).install!
    @success!

  uninstall: (name, opts) ->
    @registry(opts).uninstall name
    @success!

  load-applier: (opts) ->
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
