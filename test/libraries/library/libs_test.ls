expect = require 'chai' .expect

Libs = require '../../../lib/library/libs'

log = console.log

describe 'Libs' ->
  var libs

  lib = {}

  lib.bower =
    "ember-validations": "dist/ember-validations",
    "ember-easyform": "dist/ember-easyform",
    "moment": {
      "moment": "momentjs/index"
    }

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Libs).to.throw

      specify 'number throws' ->
        expect(-> new Libs 7).to.throw

      specify 'string throws' ->
        expect(-> new Libs 'x').to.throw


    context 'valid' ->
        expect(-> new Libs {}).to.not.throw

  describe 'valid libs' ->
    before-each ->
      libs := new Libs lib.bower

    describe 'add' ->
      specify 'adds lib' ->
        expect libs.add(blip: 'dist/blap').libs['blip'] .to.not.eql void

    describe 'remove' ->
      specify 'removes lib' ->
        expect libs.remove('blip').libs['blip'] .to.eql void


