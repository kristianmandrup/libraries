expect = require 'chai' .expect
log    = console.log

Adapter    = require '../../../../../lib/registry/config/local/pkg-adapter'

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
      path    := 'bower_components/libraries'

    describe 'registry-uri' ->
      specify 'is path' ->
        expect adapter.registry-path .to.eql path

    describe 'local-registry-path' ->
      specify 'is path' ->
        expect adapter.local-registry-path .to.eql path

    describe 'installer' ->
      specify 'is path' ->
        expect adapter.installer! .to.be.an.instance-of Installer

    describe 'registry-uri-for' ->
      specify 'bower returns remote file' ->
        expect adapter.registry-libs-uri! .to.eql path + "/bower-libs.json"

    describe 'index-content' ->
      specify 'is path' ->
        expect adapter.index-content! .to.match /ember-i18n/

    describe 'index' ->
      specify 'is json' ->
        expect adapter.index!["ember-i18n"].categories .to.include 'i18n'

    describe 'list' ->
      specify 'is json' ->
        expect adapter.list! .to.include "ember-i18n"