expect = require 'chai' .expect

Adapter     = require '../../../../lib/registry/adapter/uri-adapter'
Installer   = require '../../../../lib/registry/installer'

log = console.log

describe 'UriAdapter' ->
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
    var uri
    before ->
      adapter := new Adapter
      uri := "https://raw.githubusercontent.com/kristianmandrup/libraries/master/registry"

    describe 'registry-uri' ->
      specify 'is path' ->
        expect adapter.registry-uri .to.eql uri

    describe 'local-registry-path' ->
      specify 'is path' ->
        expect adapter.local-registry-path .to.eql './xlibs/components'

    describe 'installer' ->
      specify 'is path' ->
        expect adapter.installer! .to.be.an.instance-of Installer

    describe 'registry-uri-for' ->
      specify 'bower returns remote file' ->
        expect adapter.registry-libs-uri! .to.eql uri + "/bower-libs.json"

    describe 'index-content' ->
      specify 'is path' ->
        expect adapter.index-content! .to.match /ember-i18n/

    describe 'index' ->
      specify 'is json' ->
        expect adapter.index!["ember-i18n"].categories .to.include 'i18n'

    describe 'list' ->
      specify 'is json' ->
        expect adapter.list! .to.include "ember-i18n"

