fs     = require 'fs'
FileIO = require './file-io'

module.exports =
  read: (@file) ->
    @content ||= fs.readFileSync @file,'utf8'

  # by default overwrites
  save: (file) ->
    file ||= @file
    fs.writeFileSync file, @string!
    @

  string: ->
    JSON.stringify(@json!, null, '  ')

  exists: ->
    fs.existsSync @file

  load: (file) ->
    file ||= @file
    @_json = void
    @json file
    @

  json: (file) ->
    file ||= @file
    @_json ||= JSON.parse @read file

  print: (io = console.log) ->
    io @json!
    @
