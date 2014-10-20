expect = require 'chai' .expect

ConfigLoader        = require '../../../../../lib/registry/config/loader/json-loader'

log = console.log

describe 'JsonLoader' ->
  var loader

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

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.load-config!.dir .to.eql 'dist'

    describe 'list' ->
      specify 'has 2 entries' ->
        console.log loader.list!
        expect loader.list!.length .to.eql 2

      specify 'has a bootstrap entry' ->
        expect loader.list! .to.include "bootstrap"

    describe 'json-config' ->
      specify 'loads json for config' ->
        console.log 'json config', loader.json-config!
        expect loader.json-config! .to.be.an 'Object'

    describe 'config-file' ->
      specify 'is components/index.json' ->
        expect loader.config-file! .to.eql './xlibs/components/index.json'
