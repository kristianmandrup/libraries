expect = require 'chai' .expect
log    = console.log

Adapter     = require '../../../../../lib/registry/adapter/local/pkg-adapter'
Installer   = require '../../../../../lib/registry/config/installer'

describe 'PkgAdapter' ->
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
    var uri, path
    before ->
      adapter := new Adapter
      path    := 'bower_components/libraries/registry/bower-libs.json'

    describe 'pkg-path' ->
      specify 'is path' ->
        expect adapter.pkg-path .to.eql 'bower_components'

    describe 'registry-libs-uri' ->
      specify 'is path' ->
        expect adapter.registry-libs-uri! .to.eql path

    describe 'installer' ->
      specify 'is path' ->
        expect adapter.installer! .to.be.an.instance-of Installer

    describe 'index-content' ->
      specify 'is path' ->
        adapter.index-content!then (body) ->
          expect body .to.match /ember-i18n/

    describe 'index' ->
      specify 'is json' ->
        adapter.index!then (json) ->
          expect json["ember-i18n"].categories .to.include 'i18n'

    describe 'list' ->
      specify 'is json' ->
        adapter.list!then (list) ->
         expect list .to.include "ember-i18n"