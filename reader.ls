fs        = require 'fs'

module.exports =
  readLibs: ->
    fs.readFileSync @file,'utf8'

  libs: ->
    @libs = JSON.parse @readLibs!
