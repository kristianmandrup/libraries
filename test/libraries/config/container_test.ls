/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Container = require '../../../lib/config/container'

log = console.log

describe 'Container' ->
  var container, conf

  conf = {}

  conf.bower =
    libs: {datepicker: "blip", 'ember-validations': "dist/ember-validations"}
    components: ['bootstrap']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Container).to.throw

      specify 'bad nam throws' ->
        expect(-> new Container 7).to.throw

      specify 'non-existing file' ->
        expect(-> new Container 'x').to.not.throw


    context 'valid' ->
      specify 'obj is ok' ->
        expect(-> new Container {libs: 'x'}).to.not.throw

      specify 'allow empty obj' ->
        expect(-> new Container {}).to.not.throw

  describe 'valid container' ->
    before-each ->
      container := new Container conf.bower

    describe 'components' ->
      specify 'not empty' ->
        expect container.components! .to.not.be.empty

      specify 'includes boostrap' ->
        expect container.components! .to.include "bootstrap"

    describe 'libs' ->
      specify 'not empty' ->
        expect container.libs! .to.not.be.empty

      specify 'has ember-validations' ->
        expect container.libs!['ember-validations'] .to.eql "dist/ember-validations"

    describe 'libs-list' ->
      specify 'not empty' ->
        expect container.libs-list! .to.not.be.empty


    describe 'is-component(name)' ->
      specify 'bootstrap is a component' ->
        expect container.is-component('bootstrap') .to.be.true

      specify 'ember-validations is NOT a component' ->
        expect container.is-component('ember-validations') .to.be.false


    describe 'is-lib(name)' ->
      specify 'bootstrap is NOT a component' ->
        expect container.is-lib('bootstrap') .to.be.false

      specify 'ember-validations is NOT a component' ->
        expect container.is-lib('ember-validations') .to.be.true

    describe 'has(name)' ->
      specify 'bootstrap is there' ->
        expect container.has('bootstrap') .to.be.true

      specify 'ember-validations is there' ->
        expect container.has('ember-validations') .to.be.true



