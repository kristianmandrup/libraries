fs     = require 'fs'
FileIO = require './file-io'

module.exports =
  readLibs: ->
    fs.readFileSync @file,'utf8'

  # by default overwrites
  save: (file) ->
    file ||= @file
    fs.writeFileSync file, JSON.stringify(@libs, null, '  ')
    @

  load: ->
    @libs = JSON.parse @readLibs!
    @

  libs: ->
    @libs = JSON.parse @readLibs!
    @

  print: (io = console.log) ->
    io @libs
    @
