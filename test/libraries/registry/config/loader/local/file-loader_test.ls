expect = require 'chai' .expect

ConfigLoader        = require '../../../../../lib/registry/config/loader/file-loader'

log = console.log

describe 'FileLoader' ->
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

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.load-config!.dir .to.eql 'dist'

    describe 'config-file' ->
      specify 'is component config file' ->
        expect loader.config-file! .to.eql "./xlibs/components/bootstrap.json"

