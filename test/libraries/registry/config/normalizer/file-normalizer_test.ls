expect = require 'chai' .expect

FileNormalizer    = require '../../../../../lib/registry/config/normalizer/file-normalizer'

log = console.log

describe 'FileNormalizer' ->

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
      normalizer := new FileNormalizer 'dist/js/bootstrap.js'

    describe 'normalized' ->
      specify 'js file normalized to script entry' ->
        expect normalizer.normalized.scripts .to.eql {}

    describe 'normalize(file)' ->
      before-each ->
        normalizer.normalize!

      specify 'js file normalized to script entry' ->
        expect normalizer.normalized.scripts.files .to.include 'dist/js/bootstrap.js'

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
