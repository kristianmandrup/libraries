expect = require 'chai' .expect

Libs  = require '../../../lib/library/libs'
Lib   = require '../../../lib/library/lib'

log = console.log

describe 'Libs' ->
  var libs

  lib = {}

  lib.bower =
    "ember-validations": "dist/ember-validations",
    "ember-easyform": "dist/ember-easyform",
    "moment": {
      at: "momentjs/index.js"
      opts: {remap: 'moment/core'}
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
        expect libs.remove('blip').library('blip') .to.eql void

    describe 'location(name)' ->
      specify 'gives moment location' ->
        expect libs.location('moment') .to.eql "momentjs/index.js"

    describe 'library(name)' ->
      specify 'returns Lib instance' ->
        expect libs.library('moment') .to.be.an.instance-of Lib

      specify 'Lib instance is named moment' ->
        expect libs.library('moment').name .to.eql 'moment'

    describe 'output(name, cb)' ->
      specify 'removes lib' ->
        expect libs.output('moment') .to.eql "app.import('momentjs/index.js');"


