/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 11:45
 */
expect = require 'chai' .expect

Lib   = require '../../../lib/library/lib'

log = console.log

describe 'Lib' ->
  var lib

  libs = {}
  libs.bower =
    "ember-validations": "dist/ember-validations",
    "ember-easyform": ["dist/ember-easyform", {remap: 'x/y'}],
    "moment": {
      at: "momentjs/index.js"
      opts: {remap: 'moment/core'}
    }

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Lib).to.throw

      specify 'number throws' ->
        expect(-> new Libs 7).to.throw

      specify 'string throws' ->
        expect(-> new Lib 'x').to.throw

    context 'valid' ->
      specify 'name and location strings' ->
        expect(-> new Lib 'x', 'y').to.not.throw

    describe 'fromObject' ->
      specify 'invalid unless .at' ->
        expect(-> new Lib.fromObject 'x', {a: 'b'}).to.throw

      specify 'valid if .at' ->
        expect(-> new Lib.fromObject 'x', {at: 'b'}).to.not.throw

  context 'valid libs' ->
    before-each ->
      lib := new Lib "ember-validations", libs.bower["ember-validations"]

    describe 'output' ->
      specify 'default emit ok' ->
        expect lib.output! .to.eql "app.import('dist/ember-validations');"

      specify 'custom emit ok' ->
        expect lib.output( (loc) -> loc ) .to.eql "dist/ember-validations"

    describe 'emit' ->
      specify 'is ok' ->
        expect lib.emit("ember-validations") .to.eql "app.import('ember-validations');"
