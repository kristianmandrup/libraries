expect  = require 'chai' .expect
log     = console.log

BaseAdapter   = require '../../../../lib/registry/adapter/base-adapter'
Installer     = require '../../../../lib/registry/config/installer'

describe 'BaseAdapter' ->
  var adapter

  describe 'create' ->
    context 'invalid' ->
      specify 'number throws' ->
        expect(-> new BaseAdapter 7).to.throw

      specify 'string throws' ->
        expect(-> new BaseAdapter './xlibs/config.json').throws

      specify 'no args fails' ->
        expect(-> new BaseAdapter).to.throw

    context 'valid' ->
      specify 'empty obj ok' ->
        expect(-> new BaseAdapter {}).to.not.throw

  describe 'valid instance' ->
    before ->
      adapter := new BaseAdapter registry: 'x', name: 'bootstrap'

    describe 'registry-uri' ->
      specify 'is path' ->
        expect adapter.registry-uri .to.eql "x"

    describe 'local-registry-path' ->
      specify 'is path' ->
        expect adapter.local-registry-path .to.eql './xlibs/components'

    describe 'installer' ->
      specify 'is path' ->
        expect adapter.installer! .to.be.an.instance-of Installer

    describe 'enrich-and-normalize' ->
      specify 'enriches and normalizes' ->
        expect -> adapter.enrich-and-normalize 'bootstrap' .to.throw

