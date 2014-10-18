expect = require 'chai' .expect

FileNormalizer    = require '../../../../lib/registry/config/normalizer/file-normalizer'

log = console.log

describe 'FileNormalizer' ->
  var loader

  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new ConfigLoader 7).to.throw

    context 'valid' ->
      specify 'name string is ok' ->
        expect(-> new ConfigLoader 'x').to.not.throw

      specify 'name, path string ok' ->
        expect(-> new ConfigLoader 'x', 'y').to.not.throw

  describe 'valid instance' ->
    before ->
      loader := new FileNormalizer 'foundation'

  normalize: ->
    return @config unless @files
    for file in @files
      @normalize-one file

    # TODO: find root, then normalize all paths accordingly
    root = @find-root-path path.dirname file[0]
    unless is-blank root
      @normalized.dir = root
      @shorten-paths!

  shorten-paths: ->
    for key of @normalized
      shorten-paths-for @normalized[key]

  # can be reused at at lv with files
  shorten-paths-for: (entry) ->
    shortened-files = []
    for file in entry.files
      shortened.push @shorten-path(file)
    @normalized[key].files = shortened-files

  shorten-path: (file)->
    file.slice(@normalized.root.length)

  normalized:
    script: {}
    styles: {}
    fonts: {}

  normalize-one: (file) ->
    ext = path.extname file
    type = @find-type ext, file
    if type
      @add-file type, file
      @set-dir type, file

  # can be reused for script root etc
  find-root-path: (file-path, lv = 0, root) ->
    paths = file-path.split('/')
    match-path = paths[0 to lv].join '/'
    for file in @files
      return root unless match-path.match /^#{path}/
    return @find-root-path file, lv+1, match-path


  find-type: (type, file) ->
    for key, value of @types
      return key if value.index-of(type) > -1
    console.error "Unknown file type: #{type} for #{file}"

  types:
    script: ['js', 'coffee', 'ls']
    styles: ['css', 'scss', 'less', 'sass']
    fonts:  ['eof', 'svg']

  add-file: (type, file) ->
    normalized[type].files ||= []
    normalized[type].files.push file

  set-dir: (type, file) ->