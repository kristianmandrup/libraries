PathNormalizer  = require '../../../../../lib/registry/config/normalizer/path-normalizer'
FileShortener   = require '../../../../../lib/registry/config/normalizer/file-shortener'
DirShortener    = require '../../../../../lib/registry/config/normalizer/dir-shortener'

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

  config.xyz =
    scripts:
      files: ['x/y/z.js']

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

    describe.only 'normalize xyz' ->
      before ->
        normalizer := new PathNormalizer config.xyz, ['x/y/z.js']

      describe.only 'set-root' ->
        specify 'sets root' ->
          expect normalizer.set-root! .to.eql 'x'

      describe 'config-keys' ->
        specify 'keys' ->
          expect normalizer.config-keys! .to.eql 'scripts'

      describe 'dirs' ->
        specify 'is x,y' ->
          expect normalizer.dir! .to.eql [\x \y]

      describe 'normalize-key-dirs' ->
        specify 'normalizes dirs' ->
          expect normalizer.normalize-key-dirs! .to.eql [\x \y]

      describe 'normalize-key-files' ->
        specify 'normalizes files' ->
          expect normalizer.normalize-key-files! .to.eql [\x \y]

      describe 'normalize' ->
        specify \normalizes ->
          expect normalizer.normalize! .to.eql {
            dir: 'x',
            scripts:
              dir: 'y',
              files: ['z.js']
          }

    describe 'file-shortener' ->
      specify 'is a FileShortener' ->
        expect normalizer.file-shortener! .to.be.an.instance-of FileShortener

    describe 'dir-shortener' ->
      specify 'is a DirShortener' ->
        expect normalizer.dir-shortener! .to.be.an.instance-of DirShortener
