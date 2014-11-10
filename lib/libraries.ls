Selector      = require './select/selector'
Configurator  = require './config/configurator'
Registry      = require './registry/registry'
Generator     = require './output/generator'
ConfigLoader  = require './registry/config-loader'
Transferer    = require './transferer/transferer'

fs    = require 'fs-extra'
path  = require 'path'
chalk = require 'chalk'

module.exports =
  select: (opts = {}) ->
    @_selector ||= new Selector opts or @options

  setup: (dir = 'xlibs')->
    console.log "Installing libraries configuration in: #{dir}"
    try
      xlibs-src = path.resolve __dirname, '../setup/xlibs'
      console.log 'copy xlibs'
      fs.copy xlibs-src, "./#{dir}", (err) ~>
        return console.error(err) if err

        rcfile = path.resolve __dirname, '../setup/.librariesrc'
        console.log 'create .librariesrc'
        fs.copy rcfile, ".librariesrc", (err) ~>
          return console.error(err) if err

          unless dir is 'xlibs'
            console.log "replace xlibs with: #{dir}"
            # replace xlibs with dir chosen
            content = fs.readFileSync ".librariesrc", 'utf8'
            content = content.replace /xlibs/, dir
            fs.writeFileSync ".librariesrc", content, 'utf8'

          @was-success!
          true

    catch e
      @was-error e

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
    try
      @install opts
      cb = opts.cb if opts
      build = @select(opts).build cb
      @generator(opts).generate build
      @was-success!
    catch e
      @was-error e

  was-success: ->
    @success 'success ;>)'

  was-error: (e) ->
    @error "Error :("
    console.log e

  error: (msg) ->
    console.log chalk.red(msg)

  success: (msg) ->
    console.log chalk.green(msg)

