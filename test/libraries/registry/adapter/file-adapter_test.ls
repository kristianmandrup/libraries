expect = require 'chai' .expect

Adapter     = require '../../../../lib/registry/adapter/file-adapter'
Installer   = require '../../../../lib/registry/installer'

log = console.log

describe 'FileAdapter' ->
  var adapter

  describe 'create' ->
    context 'invalid' ->
      specify 'number throws' ->
        expect(-> new Adapter 7).to.throw

      specify 'string throws' ->
        expect(-> new Adapter './xlibs/config.json').throws

    context 'valid' ->
      specify 'no args ok' ->
        expect(-> new Adapter).to.throw

      specify 'empty obj ok' ->
        expect(-> new Adapter {}).to.not.throw

  describe 'valid instance' ->
    before ->
      adapter := new Adapter

    describe 'registry-uri' ->
      specify 'is path' ->
        expect adapter.registry-uri .to.eql "./xlibs/registry"

    describe 'local-registry-path' ->
      specify 'is path' ->
        expect adapter.local-registry-path .to.eql './xlibs/components'

    describe 'installer' ->
      specify 'is path' ->
        expect adapter.installer! .to.be.an.instance-of Installer

    describe 'index-file' ->
      specify 'is path' ->
        expect adapter.index-file! .to.eql "./xlibs/registry/index.json"

    describe 'index' ->
      specify 'is json' ->
        expect adapter.index!.registry .to.include "bootstrap"

    describe 'has' ->
      specify 'boostrap = true' ->
        expect adapter.has "bootstrap" .to.be.true

      specify 'mak = false' ->
        expect adapter.has "mak" .to.be.false

    describe 'config-file(name)' ->
      specify 'is path' ->
        expect adapter.config-file('bootstrap') .to.eql "./xlibs/registry/bootstrap.json"

    describe 'target-config(name)' ->
      specify 'is path' ->
        expect adapter.target-config('bootstrap') .to.eql "./xlibs/components/bootstrap.json"