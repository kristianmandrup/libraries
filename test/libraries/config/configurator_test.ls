/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Configurator = require '../../../lib/config/configurator'

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

    describe 'containers' ->
      specify 'is not empty' ->
        expect configurator.containers .to.not.be.empty

    describe 'install' ->
      specify 'installs' ->
        expect configurator.install! .to.not.be.void

    describe 'build' ->
      specify 'builds' ->
        expect configurator.build! .to.not.be.void
