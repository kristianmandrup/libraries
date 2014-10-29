expect  = require 'chai' .expect
log     = console.log

FileShortener = require '../../../../../lib/registry/config/normalizer/file-shortener'

describe 'FileShortener' ->
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
      shortener := new FileShortener config.simple.scripts

    describe 'shorten-files' ->
      specify 'shortens all file paths' ->
        expect shortener.shorten-files!.files .to.include 'bootstrap.js'

    describe 'shorten-path(file)' ->
      context 'with non-matching root dir' ->
        specify 'can not shorten path of file' ->
          expect shortener.shorten-path('disto/js/bootstrap.js') .to.eql 'disto/js/bootstrap.js'

      context 'with matching root dir' ->
        before-each ->
          shortener.config.dir = 'dist/js'

        specify 'shortens path of file' ->
          expect shortener.shorten-path('dist/js/bootstrap.js') .to.eql 'bootstrap.js'

