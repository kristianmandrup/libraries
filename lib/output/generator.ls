FileIO    = require '../util/file-io'
Selector  = require '../select/selector'
chalk     = require 'chalk'
util      = require 'util'
flatten   = require '../util/array' .flatten

is-blank = (str) ->
  !str or /^\s*$/.test str

lines = (build) ->
  build.join '\n    '

GlobalConfig  = require '../../../../global-config'
gconf         = new GlobalConfig

module.exports = class Generator implements FileIO
  (@options = {}) ->
    @options.path ||= @build-file!
    @options.env  ||= process.env.environment || 'dev'
    @

  build-file: ->
    if @options.env then @env-file! else gconf.builds.dir

  env-path: ->
    [gconf.dir, @options.env,  'builds'].join '/'

  build: (cb) ->
    @selector!.build cb

  selector: ->
    new Selector

  target-file: ->
    "imports-#{@options.env}.js"

  target-path: ->
    [@options.path, @target-file!].join '/'

  load: ->
    require @target-path!

  generate: (build, opts = {})->
    opts.cb        ||= @options.cb
    opts.wrapper   ||= @options.wrapper or @wrapped
    build          ||= @build opts.cb

    content        = opts.wrapper lines(@unpacked(build))
    return @ if is-blank content

    @write-file @target-path!, content
    @log @success!
    @

  log: (msg) ->
    console.log msg

  unpacked: (build) ->
    flatten build

  wrapped: (build) ->
    """
(function() {
  module.exports = function(app) {
    #{build}
  }
}).call(this);
    """

  success: ->
    chalk.green "#{@options.env} build generated @ #{@target-path!}"
