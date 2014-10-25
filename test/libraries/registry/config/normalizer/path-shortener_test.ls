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
      shortener := new PathShortener config.simple.scripts

    describe 'shorten-file-paths' ->
      specify 'shortens all file paths' ->
        expect shortener.shorten-file-paths!.files .to.include 'bootstrap.js'

    describe 'shorten-dir' ->
      specify 'shortens dir path' ->
        expect shortener.shorten-dir('dist').dir .to.eql 'js'

    describe 'shorten-path(file)' ->
      context 'with non-matching root dir' ->
        specify 'can not shorten path of file' ->
          expect shortener.shorten-path('dist/js/bootstrap.js') .to.eql 'dist/js/bootstrap.js'

      context 'with matching root dir' ->
        before-each ->
          shortener.config.dir = 'dist/js'

        specify 'shortens path of file' ->
          expect shortener.shorten-path('dist/js/bootstrap.js') .to.eql 'bootstrap.js'

