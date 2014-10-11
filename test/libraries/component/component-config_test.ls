/**
 * User: kristianmandrup
 * Date: 10/10/14
 * Time: 21:08
 */
expect = require 'chai' .expect

Config = require '../../../lib/component/component-config'

log = console.log

describe 'ComponentConfig' ->
  var config, name

  before ->
    name := 'bootstrap'

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Config).to.throw

      specify 'bad nam throws' ->
        expect(-> new Config 7).to.throw

      specify 'a name is ok' ->
        expect(-> new Config 'x').to.not.throw

      specify 'obj throws' ->
        expect(-> new Config {libs: 'x'}, 'blip').to.throw

    context 'valid' ->
      specify 'allow empty obj' ->
        expect(-> new Config name, name).to.not.throw

  describe 'valid config' ->
    before-each ->
      config := new Config name, './xlibs/components'

    describe 'config' ->
      specify 'has name set' ->
        expect config.name .to.equal name

    describe 'valid-config' ->
      specify 'any object is valid' ->
        expect config.valid-config({}) .to.eql {}

      specify 'any non-object is invalid' ->
        expect (-> config.valid-config('x')) .to.throw

    describe 'component-file' ->
      specify 'is combined into a local repo file path' ->
        expect config.component-file! .to.eql './xlibs/components/bootstrap.json'

      specify 'blip is non-existing file path' ->
        expect config.component-file('blip') .to.eql './xlibs/components/blip.json'

    describe 'has-local' ->
      specify 'bootstrap is in local repo' ->
        expect config.has-local! .to.be.true

    describe 'has-local(name)' ->
      specify 'bootstrap is in local repo' ->
        expect config.has-local 'bootstrap' .to.be.true

      specify 'blip is not in local repo' ->
        expect config.has-local 'blip' .to.be.false

    describe 'registry-file' ->
      specify 'is combined into a registry file path' ->
        expect config.registry-file! .to.eql './xlibs/registry/bootstrap.json'

    describe 'load' ->
      context 'registry config' ->
        specify 'loads config from registry' ->
          expect( -> config.load './xlibs/registry/bootstrap.json').to.throw

      context 'local config' ->
        specify 'loads config from local repo' ->
          expect config.load('./xlibs/components/bootstrap.json').dir .to.eql 'dist'

    describe 'loadIt' ->
      context 'from local config' ->
        specify 'loads config from registry' ->
          expect config.load-it!.dir .to.eql 'dist'


