expect = require 'chai' .expect
log    = console.log

Adapter       = require '../../../../lib/registry/adapter/local-adapter'
FileAdapter   = require '../../../../lib/registry/adapter/local/file-adapter'
PkgAdapter    = require '../../../../lib/registry/adapter/local/pkg-adapter'

describe 'LocalRegistryAdapter' ->
  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
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
        expect adapter.adapter! .to.be.an.instance-of PkgAdapter

    describe 'selected-adapter' ->
      specify 'finds adapter' ->
        expect adapter.selected-adapter! .to.eql PkgAdapter

    xdescribe 'load' ->
      specify 'loads registry' ->
        expect adapter.load! .to.eql {}