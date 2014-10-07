/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Configurator = require '../../lib/config/configurator'

log = console.log

describe 'Configurator' ->
  var configurator, conf

  conf = {}

  conf.bootstrap =
    dir: 'dist'
    scripts:
      files: ['js/bootstrap.js']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Configurator).to.throw

      specify 'bad nam throws' ->
        expect(-> new Configurator 7).to.throw

      specify 'non-existing file' ->
        expect(-> new Configurator 'x').to.not.throw


    context 'valid' ->
        expect(-> new Configurator './xlibs/config.json').to.not.throw

  describe 'valid component' ->
    before-each ->
      configurator := new Configurator

    describe 'config' ->
      specify 'loaded' ->
        expect configurator.config.vendor .to.eql "vendor/prod"

    describe 'part' ->
      specify 'bower is not empty' ->
        expect configurator.part('bower') .to.not.be.empty

      specify 'vendor is empty' ->
        expect configurator.part('vendor') .to.eql {}

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
