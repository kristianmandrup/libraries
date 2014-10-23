expect = require 'chai' .expect

FileNormalizer    = require '../../../../../lib/registry/config/normalizer/file-normalizer'

log = console.log

describe 'FileNormalizer' ->

  config = {}
  config.simple =
    main: {}
    scripts: {}

  describe 'create(@file)' ->
    describe 'invalid' ->
      specify 'no args invalid' ->
        expect -> new FileNormalizer .to.throw

    describe 'valid' ->
      specify 'name arg is valid' ->
        expect(-> new FileNormalizer 'x').to.throw

  context 'instance' ->
    var normalizer
    before-each ->
      normalizer := new FileNormalizer config.simple

    describe 'normalized' ->
      specify 'js file normalized to scripts entry' ->
        expect normalizer.normalized.scripts .to.eql {}

    describe.only 'normalize(file)' ->
      before-each ->
        normalizer.normalize 'dist/js/bootstrap.js'
        # console.log 'normalized', normalizer.normalized

      specify 'js file normalized to script entry' ->
        expect normalizer.normalized.scripts.files .to.include 'dist/js/bootstrap.js'

      xspecify 'js dir normalized' ->
        expect normalizer.normalized.scripts.dir .to.eql 'dist/js'

    describe 'find-type(ext, file)' ->
      specify 'identifies js as a scripts ext' ->
        expect normalizer.find-type('js') .to.eql 'scripts'

    describe 'extension-of(file)' ->
      specify '.js file is js ext' ->
        expect normalizer.extension-of('dist/js/bootstrap.js') .to.eql 'js'

    describe 'types' ->

    describe 'add-file' ->
      specify 'js file normalized to script entry' ->
        expect normalizer.add-file('scripts').normalized.scripts.files .to.include 'dist/js/bootstrap.js'

    describe 'set-dir' ->
      specify 'js file normalized to script entry' ->
        expect normalizer.set-dir('scripts').normalized.scripts.dir .to.eql 'dist/js'
