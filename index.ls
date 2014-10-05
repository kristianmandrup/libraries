module.exports =
  libraries: require '.libraries'

  dummy-app: (io) ->
    io ||= console.log
    return {
      import: (location, opts = '') ->
        x = if opts then '", ' else '"'
        io 'app.import(  "' + location + x, opts, ');'

      bowerDirectory: 'bower_components'
    }
