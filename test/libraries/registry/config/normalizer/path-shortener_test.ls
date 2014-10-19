expect = require 'chai' .expect

PathShortener = require '../../../../../lib/registry/config/normalizer/path-shortener'

log = console.log

describe 'PathShortener' ->

  config = {}
  config.simple =
    dir: 'dist/js'
    main:
      files: ['dist/js/bootstrap.js']
    scripts:
      dir: 'dist/js'
      files: ['bootstrap.js']

  describe 'create(config)' ->

  context 'instance' ->
    var shortener

    before-each ->
      shortener := new PathShortener config.simple

    describe 'shorten-paths' ->
      specify 'shortens all paths' ->
        expect shortener.shorten-paths!.scripts.files .to.include 'bootstrap.js'

    # can be reused at at lv with files
    describe 'shorten-paths-for(entry)' ->
      specify 'shortens all paths' ->
        expect shortener.shorten-paths-for('scripts', config.simple.scripts).files .to.include 'bootstrap.js'

    describe 'shorten-path(file)' ->
      specify 'shortens path of file' ->
        expect shortener.shorten-path('dist/js/bootstrap.js') .to.eql 'bootstrap.js'

