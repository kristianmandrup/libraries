/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:45
 */
expect = require 'chai' .expect

ConfigLoader        = require '../../../../lib/registry/config-loader/local'

log = console.log

describe 'LocalConfigLoader' ->
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

    describe 'has-local' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-config! .to.be.true

    describe 'has-local(name)' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-config 'bootstrap' .to.be.true

      specify 'blip is not in local repo' ->
        expect loader.has-config 'blip' .to.be.false

    describe 'config-file' ->
      specify 'is combined into a local repo file path' ->
        expect loader.config-file! .to.eql './xlibs/components/bootstrap.json'

      specify 'blip is non-existing file path' ->
        expect loader.config-file('blip') .to.eql './xlibs/components/blip.json'

    describe 'load' ->
      specify 'loads config from local repo' ->
        expect loader.load('./xlibs/components/bootstrap.json').dir .to.eql 'dist'
