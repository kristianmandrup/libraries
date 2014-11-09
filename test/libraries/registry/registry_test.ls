expect = require 'chai' .expect

LocalAdapter  = require '../../../lib/registry/adapter/local-adapter'

Registry      = require '../../../lib/registry/registry'

log = console.log

describe 'Registry' ->
  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new Registry 7).to.throw

    context 'valid' ->
      specify 'no args is ok' ->
        expect(-> new Registry type: 'local').to.not.throw

      specify 'type: is ok' ->
        expect(-> new Registry type: 'local').to.not.throw

    context 'valid instance' ->
      var registry

      before-each ->
        registry := new Registry

      describe 'selected-adapter' ->
        specify 'is LocalAdapter class' ->
          expect registry.selected-adapter! .to.eql LocalAdapter

      describe.only 'adapter' ->
        specify 'is LocalAdapter' ->
          expect registry.adapter! .to.be.an.instance-of LocalAdapter

      describe 'install(name)' ->
        specify 'installs bootstrap' ->
          expect registry.install 'bootstrap' .to.not.throw


