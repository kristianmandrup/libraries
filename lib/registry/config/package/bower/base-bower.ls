FileIO            = require '../../../../util/file-io'
BaseBowerAdapter  = require './base-bower'

GlobalConfig  = require '../../../../global-config'
gconf         = new GlobalConfig

module.exports = class LocalBowerAdapter implements FileIO
  (@name, @options = {}) ->
    @validate!
    @repos.push @options.repo if @options.repo
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of bower component must be a String, was: #{util.inspect @name}"

  adapt: ->
    @files!.then (files) ->
      files: files

  files: ->
    if @has-main! then @main-files! else []

  has-main: ->
    @main-files!.then (files) ->
      files && files.length > 0

  main-files: ->
    @bower-json!.then (json) ->
      json.main

  bower-json: ->
    @bower ||= @retrieve!.then (body) ->
      jsonlint.parse body

  retrieve: ->
    @retrieve-body @repo-uri!