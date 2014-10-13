FileIO    = require '../file-io'
Selector  = require '../select/selector'
chalk     = require 'chalk'
util      = require 'util'
flatten   = require '../util/array' .flatten

is-blank = (str) ->
  !str or /^\s*$/.test str

lines = (build) ->
  build.join '\n    '

module.exports = class Generator implements FileIO
  (@options = {}) ->
    @options.env  ||= process.env.environment || 'dev'
    @options.path ||= './xlibs/builds'
    @

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
    # [].concat.apply([],build);

  wrapped: (build) ->
    """
(function() {
  module.exports = function(app) {
    #{build}
  }
}).call(this);
    """

  # TODO
  success: ->
    chalk.green "#{@options.env} build generated @ #{@target-path!}"
