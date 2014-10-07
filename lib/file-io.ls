fs     = require 'fs'
FileIO = require './file-io'

module.exports =
  read: ->
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

  load: ->
    @_json = void
    @json!
    @

  json: ->
    @_json ||= JSON.parse @read!

  print: (io = console.log) ->
    io @json!
    @
