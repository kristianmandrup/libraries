expect  = require 'chai' .expect
log     = console.log

DirShortener = require '../../../../../lib/registry/config/normalizer/dir-shortener'

describe 'DirShortener' ->
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
      shortener := new DirShortener config.simple.scripts

    describe 'shorten-dir' ->
      specify 'shortens dir path' ->
        config = shortener.shorten-dir('dist')
        log config
        expect config.dir .to.eql 'js'
