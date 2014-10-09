/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
expect = require 'chai' .expect

Registry = require '../../../lib/registry/registry'

log = console.log

describe 'Registry' ->
  var registry


  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new Registry 7).to.throw

    context 'valid' ->
      specify 'no args ok' ->
        expect(-> new Registry).to.not.throw

      specify 'string arg ok' ->
        expect(-> new Registry './xlibs/config.json').to.not.throw

  describe 'valid instance' ->
    before ->
      registry := new Registry
      log registry

    describe 'registry-uri' ->
      specify 'is path' ->
        expect registry.registry-uri .to.eql "./xlibs/registry"

    describe 'local-registry-path' ->
      specify 'is path' ->
        expect registry.local-registry-path .to.eql "./xlibs/registry"

    describe 'index-file' ->
      specify 'is path' ->
        expect registry.index-file! .to.eql "./xlibs/registry/index.json"

    describe 'index' ->
      specify 'is json' ->
        expect registry.index!.registry .to.include "bootstrap"

    describe 'config-file(name)' ->
      specify 'is path' ->
        expect registry.config-file('bootstrap') .to.eql "./xlibs/registry/bootstrap.json"

    describe 'target-config(name)' ->
      specify 'is path' ->
        expect registry.target-config('bootstrap') .to.eql "./xlibs/registry/bootstrap.json"

    describe 'install(name, path)' ->
      before ->
        registry.install('bootstrap')

      specify 'is installed' ->
        expect 1

    describe 'uninstall(name, path)' ->
      before ->
        registry.uninstall('bootstrap')

      specify 'is uninstalled' ->
        expect 1

