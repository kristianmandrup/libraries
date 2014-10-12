/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:45
 */
expect = require 'chai' .expect

ConfigLoader        = require '../../../lib/registry/config-loader'
RemoteConfigLoader  = require '../../../lib/registry/config-loader/remote'
LocalConfigLoader   = require '../../../lib/registry/config-loader/local'

log = console.log

describe 'ConfigLoader' ->
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

    describe 'local' ->
      specify 'is LocalConfigLoader' ->
        expect loader.local! .to.be.an.instance-of LocalConfigLoader

    describe 'remote' ->
      specify 'is RemoteConfigLoader' ->
        expect loader.remote! .to.be.an.instance-of RemoteConfigLoader

    describe 'none-loaded' ->
      specify 'displays error' ->
        expect loader.none-loaded! .to.eql void
