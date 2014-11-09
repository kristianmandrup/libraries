expect = require 'chai' .expect

Adapter  = require '../../../../lib/registry/adapter/basic-adapter'

log = console.log

describe 'Adapter' ->
  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new Adapter 7).to.throw

    context 'valid' ->
      specify 'no args is ok' ->
        expect(-> new Adapter type: 'local').to.not.throw

      specify 'type: is ok' ->
        expect(-> new Adapter type: 'local').to.not.throw

    context 'valid instance' ->
      var adapter

      before-each ->
        adapter := new Adapter

      describe 'type' ->
        specify 'is bower' ->
          expect adapter.type .to.eql 'bower'

      describe 'installer-type' ->
        specify 'is json' ->
          expect adapter.installer-type .to.eql 'json'

      describe 'adapter-type' ->
        specify 'is pkg' ->
          expect adapter.adapter-type .to.eql 'pkg'

      describe 'selected-adapter' ->
        specify 'throws' ->
          expect -> adapter.selected-adapter! .to.throw

      describe 'adapter' ->
        specify 'is LocalAdapter' ->
          expect -> adapter.adapter! .to.throw

      describe 'install' ->
        specify 'installs it' ->
          expect -> adapter.install! .to.throw

      describe 'load' ->
        specify 'installs bootstrap' ->
          expect -> adapter.load! .to.throw

