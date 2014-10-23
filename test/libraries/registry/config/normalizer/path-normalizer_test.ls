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
      files: ['bootstrap.js']

  describe 'create(@config)' ->

  context 'instance' ->
    var normalizer

    before-each ->
      normalizer := new PathNormalizer config.simple, ['dist/js/bootstrap.js', 'dist/js/init.js', 'dist/js/boot/config.js']

    describe 'normalize' ->
      var config

      before-each ->
        config := normalizer.normalize!
        # log 'config', config

      specify 'sets root dir' ->
        expect config.dir .to.eql "dist/js"

      specify 'shortens main files by root' ->
        expect config.main.files.0 .to.eql "bootstrap.js"

    describe 'normalize-for(key)' ->

    describe 'root' ->
      specify 'finds root' ->
        expect normalizer.root! .to.eql "dist/js"

    describe 'path-shortener' ->
      specify 'is a PathShortener' ->
        expect normalizer.path-shortener! .to.be.an.instance-of PathShortener
