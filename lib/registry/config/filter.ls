GlobalConfig  = require '../../global-config'
gconf         = new GlobalConfig
path          = require 'path'

module.exports = class Filter
  (@config) ->
    @validate!
    @

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to filter must be an Object, was: #{@config}"

  filter: ->
    res = {}
    for key in @filter-pref-keys!
      res[key] ||= {}
      res[key].files = @filter-on key
    res

  filter-on: (name) ->
    files = @config-for(name).files
    prefs = @prefs-for(name)
    res = []
    for file in files
      filtered = @filter-one files, file, prefs
      for f in filtered
        res.push f unless res.index-of(f) > -1
    res

  filter-pref: (files, prefs) ->
    prefs = [prefs] unless typeof! prefs is 'Array'
    for pref in prefs
      for file in files
        return file if @matches file, pref

  filter-one: (files, file, prefs) ->
    #  for each file, filter files with same filename
    #  find file that has highest priority extension according to prefs
    #  remove other files of same name
    # group by same filename without ext
    same-files = @same files, file
    # return [file] unless same-files.length > 1
    best-file  = @filter-pref same-files, prefs
    files.filter (file) ->
      file is best-file or same-files.index-of(file) is -1

  same: (files, file) ->
    fname = @file-name file
    files.filter (name) ~>
      @file-name(name) is fname

  file-name: (file) ->
    lname = path.basename file, path.extname(file)
    matches = lname.match /(.*)\./
    if matches then matches[1] else lname

  matches: (file, pref) ->
    return false unless typeof! pref is 'String'
    # pref = ".#{pref}" unless pref[0] is '.'
    bname = path.basename file
    matches = file.match /\.(.*)/
    ext = matches[1] # path.extname(file)
    !!(ext is pref)

  config-for: (name) ->
    @config[name]

  prefs-for: (name)->
    @filter-prefs![name]

  filter-pref-keys: ->
    Object.keys @filter-prefs!

  filter-prefs: ->
    @prefs ||= gconf.preferences!