FileIO    = require '../file-io'
Selector  = require '../select/selector'
chalk     = require 'chalk'

module.exports = class Generator implements FileIO
  (@options = {}) ->
    @options.env  ||= process.env.environment || 'dev'
    @options.path ||= './xlibs/builds'
    @

  build: (cb) ->
    @select!.build cb

  select: ->
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
    @save @target-path!, opts.wrapper(@unpacked build)
    console.log @success!
    @

  unpacked: (build) ->
    [].concat.apply([],build);

  wrapped: (build) ->
    """
function() {
  module.exports = function(app) {
    #{build}
  }
}();
    """

  # TODO
  success: ->
    chalk.green "#{@options.env} build generated @ #{@target-path!}"
