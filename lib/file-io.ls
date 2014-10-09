fs     = require 'fs'
FileIO = require './file-io'

module.exports =
  read: (file) ->
    file ||= @file
    @content ||= fs.readFileSync file,'utf8'

  # by default overwrites
  save: (file, type = 'json') ->
    file ||= @file
    console.log file
    fs.writeFileSync file, @string(file)
    @

  save-content: (file) ->
    file ||= @file
    console.log file
    fs.writeFileSync file, @content
    @

  string: (file) ->
    file ||= @file
    JSON.stringify(@json(file), null, '  ')

  exists: ->
    fs.existsSync @file

  load: (file) ->
    file ||= @file
    @_json = void
    @json file
    @

  json: (file) ->
    file ||= @file
    console.log file
    @_json ||= JSON.parse @read file

  print: (io = console.log) ->
    io @json!
    @
