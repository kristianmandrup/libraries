expect = require 'chai' .expect

RootPath = require '../../../../../lib/registry/config/normalizer/root-path'

log = console.log

describe 'RootPath' ->
  config = {}
  config.simple =
    dir: 'dist'
    main:
      files: ['dist/js/bootstrap.js']
    scripts:
      files: ['dist/js/bootstrap.js', 'dist/js/bootit.js']
    styles:
      files: ['dist/css/bootstrap.js']

  describe 'create(config)' ->

  context 'instance' ->
    var root-path, files

    before-each ->
      files     := config.simple.scripts.files
      root-path := new RootPath files

    describe 'find root path' ->
      specify 'longest common path is dist/js' ->
        expect root-path.find 'dist/js/bootstrap.js' .to.eql 'dist/js'

      specify 'no common path is undefined' ->
        expect root-path.find 'bootstrap.js' .to.eql void
