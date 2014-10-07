FileIO = require 'file-io'

module.exports = class Generator implements FileIO
  (@options = {env: 'dev'}) ->
    @options.path ||= './xlibs'
    @

  imports: ->
    @libraries.create-imports!

  target-file: ->
    "imports-#{@options.env}.js"

  target-file: ->
    [@options.path, @target-file!].join '/'

  generate: ->
    @save @target-file, @imports!
