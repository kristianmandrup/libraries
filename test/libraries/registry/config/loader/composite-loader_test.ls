expect = require 'chai' .expect

ConfigLoader        = require '../../../../../lib/registry/config/loader/composite-loader'

log = console.log

describe 'JsonLoader' ->
  var loader

  config =
    local:  './xlibs/components/bootstrap.json'
    remote: './xlibs/registry/bootstrap.json'

  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new ConfigLoader 7).to.throw

    context 'valid' ->
      specify 'name string is ok' ->
        expect(-> new ConfigLoader 'x').to.not.throw

      specify 'name, path string ok' ->
        expect(-> new ConfigLoader 'x', 'y').to.not.throw

  describe 'valid instance' ->
    before ->
      loader := new ConfigLoader 'bootstrap'
      loader.config-file = ->
        config.local
      loader.has-config = ->
        true

    describe 'load' ->
      specify 'loads json from local' ->
        expect( -> config.load config.local).to.not.throw

      specify 'no json to load - fails' ->
        expect( -> config.load config.remote).to.throw

    describe 'has-config' ->
      specify 'has config' ->
        expect loader.has-config! .to.be.true

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.load-config!.dir .to.eql 'dist'

    describe 'loaders' ->
      specify 'file and json' ->
        expect loader.loaders!.length .to.eql 2

    describe 'file-loader' ->
      specify 'is a FileLoader' ->
        expect loader.file-loader! .to.be.an.instance-of FileLoader

    describe 'json-loader' ->
      specify 'is a FileLoader' ->
        expect loader.json-loader! .to.be.an.instance-of JsonLoader