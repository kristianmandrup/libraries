expect = require 'chai' .expect

CompositeLoader    = require '../../../../../lib/registry/config/loader/composite-loader'
LocalLoader        = require '../../../../../lib/registry/config/loader/local-loader'
RemoteLoader       = require '../../../../../lib/registry/config/loader/remote-loader'

log = console.log

describe 'CompositeLoader' ->
  var loader

  config =
    local:  './xlibs/components/bootstrap.json'

  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new CompositeLoader 7).to.throw

    context 'valid' ->
      specify 'name string is ok' ->
        expect(-> new CompositeLoader 'x').to.not.throw

      specify 'name, path string ok' ->
        expect(-> new CompositeLoader 'x', 'y').to.not.throw

  describe 'valid instance' ->
    before ->
      loader := new CompositeLoader 'bootstrap'

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.load-config!.dir .to.eql 'dist'