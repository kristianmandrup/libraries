expect = require 'chai' .expect

FileNormalizer    = require '../../../../lib/registry/config/normalizer/file-normalizer'

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
      normalizer := new FileNormalizer

    describe 'normalize(file)' ->

    describe 'find-type' ->

    describe 'types' ->

    describe 'add-file' ->

    describe 'set-dir' ->
