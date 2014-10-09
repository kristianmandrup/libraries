/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Container = require '../../lib/config/container'

log = console.log

describe 'Configurator' ->
  var container, conf

  conf = {}

  conf.bootstrap =
    dir: 'dist'
    scripts:
      files: ['js/bootstrap.js']

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
      container := new Container

    describe 'components' ->
      specify 'not empty' ->
        expect configurator.part('bower').components .to.not.be.empty

      specify 'includes boostrap' ->
        expect configurator.part('bower').components .to.include "boostrap"

    describe 'libs' ->
      specify 'not empty' ->
        expect configurator.part('bower').libs .to.not.be.empty

      specify 'has ember-validations' ->
        expect configurator.part('bower').libs['ember-validations'] .to.eql "dist/ember-validations"

    describe 'cmps' ->
      specify 'an instance' ->
        expect configurator.cmps! .to.not.eql void
