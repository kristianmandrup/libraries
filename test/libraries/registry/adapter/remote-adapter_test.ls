expect = require 'chai' .expect
log    = console.log

Adapter       = require '../../../../lib/registry/adapter/remote-adapter'
UriAdapter    = require '../../../../lib/registry/adapter/remote/uri-adapter'

describe 'RemoteRegistryAdapter' ->
  describe 'create' ->
    context 'invalid' ->
      specify 'num throws' ->
        expect(-> new Adapter 7).to.throw

    context 'valid' ->
      specify 'no args ok' ->
        expect(-> new Adapter).to.not.throw

      specify 'empty object is ok' ->
        expect(-> new Adapter {}).to.not.throw

  describe 'valid instance' ->
    var adapter

    before-each ->
      adapter := new Adapter

    describe 'bad-adapter' ->
      specify 'throws' ->
        expect -> adapter.bad-adapter! .to.throw

    describe 'adapter' ->
      specify 'creates adapter' ->
        expect adapter.adapter! .to.be.an.instance-of UriAdapter

    describe 'selected-adapter' ->
      specify 'finds adapter' ->
        expect adapter.selected-adapter! .to.eql UriAdapter

    xdescribe 'load' ->
      specify 'loads registry' ->
        expect adapter.load! .to.eql {}