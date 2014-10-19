expect = require 'chai' .expect

FileNormalizer    = require '../../../../lib/registry/config/normalizer/file-normalizer'

log = console.log

describe 'FilesNormalizer' ->
  describe 'create(@config)' ->
    describe 'invalid' ->
      specify 'no args invalid' ->
        expect -> new FilesNormalizer .to.throw

    describe 'valid' ->
      specify 'name arg is valid' ->
        expect(-> new FilesNormalizer 'x').to.throw

  context 'valid instance' ->
    var normalizer
    before-each ->
      normalizer := new FilesNormalizer

    describe 'normalize' ->
      expect normalizer.normalize! .to.eql {}

    describe 'file-normalizer' ->
      expect normalizer.file-normalizer! .to.be.an.instance-of FileNormalizer

    describe 'path-normalizer' ->
      expect normalizer.path-normalizer! .to.be.an.instance-of PathNormalizer

    describe 'normalized' ->
