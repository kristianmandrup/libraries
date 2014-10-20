fs        = require 'fs-extra'
jsonlint  = require 'jsonlint'
FileIO    = require './file-io'

module.exports =
  read: (file) ->
    file ||= @file
    @content ||= fs.readFileSync file, 'utf8'

  # by default overwrites
  save: (file) ->
    file ||= @file
    @write-file file, @string(file)

  write-file: (file, content) ->
    file ||= @file
    content ||= @content
    @create-path file
    fs.writeFileSync file, content, 'utf8'

  remove-file: (file) ->
    file ||= @file
    fs.unlinkSync file

  create-path: (file) ->
    file ||= @file
    path = require('path').dirname file
    fs.mkdirp path

  save-content: (file, content) ->
    file ||= @file
    content ||= @content
    @write-file content
    @

  string: (file) ->
    file ||= @file
    JSON.stringify(@json(file), null, '  ')

  exists: (file) ->
    file ||= @file
    fs.existsSync file

  load: (file) ->
    file ||= @file
    @_json = void
    @json file
    @

  json: (file) ->
    file ||= @file
    @_json ||= JSON.parse @read file

  jsonlint: (content) ->
    content ||= @content
    @_jsonlint ||= jsonlint.parse content

  print: (io = console.log) ->
    io @json!
    @

  error: (msg) ->
    console.error msg

