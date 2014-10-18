/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:46
 */
expect = require 'chai' .expect

ConfigLoader      = require '../../../../lib/registry/config-loader/remote'
Registry          = require '../../../../lib/registry/registry'

log = console.log

describe 'LocalConfigLoader' ->
  var loader

  config =
    local:  './xlibs/components/bootstrap.json'
    remote: './xlibs/registry/bootstrap.json'

  component =
    remote: 'foundation'
    local: 'bootstrap'

  remote-location = (name) ->
    './xlibs/registry/' + name + '.json'

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
      loader := new ConfigLoader 'foundation'

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.load-config!.dir .to.eql 'dist'

    describe 'has-local' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-config! .to.be.true

    describe 'has-local(name)' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-config 'bootstrap' .to.be.true

      specify 'mak is not in local repo' ->
        expect loader.has-config 'mak' .to.be.false

    describe 'config-file' ->
      specify 'is combined into a local repo file path' ->
        expect loader.config-file! .to.eql remote-location 'foundation'

      specify 'blip is non-existing file path' ->
        expect loader.config-file('blip') .to.eql remote-location 'blip'

    describe 'registry' ->
      specify 'is a Registry' ->
        expect loader.registry! .to.be.an.instance-of Registry


