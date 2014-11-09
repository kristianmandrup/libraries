expect = require 'chai' .expect

Normalizer      = require '../../../../../lib/registry/config/normalizer/config-normalizer'
PathNormalizer  = require '../../../../../lib/registry/config/normalizer/path-normalizer'
FileNormalizer  = require '../../../../../lib/registry/config/normalizer/file-normalizer'

log = console.log

describe 'ConfigNormalizer' ->
  describe 'create(@config)' ->
    describe 'invalid' ->
      specify 'no args invalid' ->
        expect -> new Normalizer .to.throw

    describe 'valid' ->
      specify 'name arg is valid' ->
        expect(-> new Normalizer 'x').to.throw

  context 'valid instance' ->
    var normalizer, config

    before-each ->
      config :=
        files: ['dist/js/bootstrap.js', 'dist/css/bootstrap.css']

      normalizer := new Normalizer config
      # log 'normalizer', normalizer

    describe 'normalize' ->
      specify 'normalizes config' ->
        expect normalizer.normalize! .to.eql {}

    describe 'file-normalizer' ->
      specify 'creates one' ->
        expect normalizer.file-normalizer! .to.be.an.instance-of FileNormalizer

    describe 'path-normalizer' ->
      specify 'creates one' ->
        expect normalizer.path-normalizer! .to.be.an.instance-of PathNormalizer

    describe 'normalized' ->
      before ->
        config :=
          files: ['dist/js/bootstrap.js', 'dist/css/bootstrap.css']

        normalizer := new Normalizer config
        normalizer.normalize!
        # log 'normalized', normalizer.normalized

      specify 'root is dist' ->
        expect normalizer.normalized.dir .to.equal 'dist'

      specify 'scripts normalized to have js as relative root dir' ->
        expect normalizer.normalized.scripts .to.eql {
          dir: 'js'
          files: ['bootstrap.js']
        }

      specify 'styles is normalized to have css as relative root dir' ->
        expect normalizer.normalized.styles .to.eql {
          dir: 'css'
          files: ['bootstrap.css']
        }

  context.only 'normalize deeply nested file' ->
    var normalizer
    before-each ->
      normalizer := new Normalizer {files: ['x/y/z.js']}, {type: 'component'}

    describe 'normalize' ->
      specify 'normalizes config' ->
        expect normalizer.normalize! .to.eql {
          dir: 'x'
          scripts: {
            dir: 'y',
            files: ['z.js']
          }
        }
