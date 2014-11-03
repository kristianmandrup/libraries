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
    for key in @filter-pref-keys
      @filter-on key

  filter-on: (name) ->
    files = @config-for(name).files
    for pref in @prefs-for(name)
       return @filter-pref files, pref

  filter-pref: (files, prefs) ->
    prefs = [prefs] unless typeof! prefs is 'Array'
    for file in files
      for pref in prefs
        return file if @matches file, pref

  filter-one: (files, file, prefs) ->
    #  for each file, filter files with same filename
    #  find file that has highest priority extension according to prefs
    #  remove other files of same name
    # group by same filename without ext
    same-files = @same files, file
    best-file  = @filter-pref same-files, prefs
    files.filter (file) ->
      file is best-file or same-files.index-of(file) is -1

  same: (files, file) ->
    fname = @file-name file
    files.filter (name) ~>
      @file-name(name) is fname

  file-name: (file) ->
    path.basename file, path.extname(file)

  matches: (file, pref) ->
    return false unless typeof! pref is 'String'
    pref = ".#{pref}" unless pref[0] is '.'
    !!(path.extname(file) is pref)

  config-for: (name) ->
    @config[name]

  prefs-for: (name)->
    @filter-prefs![name]

  filter-pref-keys: ->
    Object.keys @filter-prefs!

  filter-prefs: ->
    @prefs ||= gconf.preferences!