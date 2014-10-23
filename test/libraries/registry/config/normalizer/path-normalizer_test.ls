PathNormalizer  = require '../../../../../lib/registry/config/normalizer/path-normalizer'
PathShortener   = require '../../../../../lib/registry/config/normalizer/path-shortener'

expect  = require 'chai' .expect
log     = console.log

describe 'PathNormalizer' ->

  config = {}
  config.simple =
    main:
      files: ['dist/js/bootstrap.js']
    scripts:
      files: ['dist/js/bootstrap.js']
    styles:
      files: ['dist/css/bootstrap.css']

  describe 'create(@config)' ->

  context 'instance' ->
    var normalizer

    before ->
      normalizer := new PathNormalizer config.simple, ['dist/js/bootstrap.js', 'dist/js/bootstrap.js', 'dist/css/bootstrap.css']

    describe 'normalize' ->
      var config

      before ->
        config := normalizer.normalize!

      specify 'sets root dir to dist' ->
        expect config.dir .to.eql "dist"

      specify 'shortens main files to file name' ->
        expect config.main.files.0 .to.eql "bootstrap.js"

      specify 'main dir = js' ->
        expect config.main.dir .to.eql "js"

      specify 'styles dir = css' ->
        expect config.styles.dir .to.eql 'css'

      specify 'scripts dir = js' ->
        expect config.styles.dir .to.eql 'css'

      specify 'scripts dir = js' ->
        expect config.styles.files.0 .to.eql 'bootstrap.css'

    describe 'path-shortener' ->
      specify 'is a PathShortener' ->
        expect normalizer.path-shortener! .to.be.an.instance-of PathShortener
