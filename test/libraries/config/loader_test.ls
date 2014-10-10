/**
 * User: kristianmandrup
 * Date: 10/10/14
 * Time: 21:08
 */
expect = require 'chai' .expect

Loader = require '../../../lib/config/loader'

log = console.log

describe 'Loader' ->
  var loader, name

  before ->
    name := 'bootstrap'

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Loader).to.throw

      specify 'bad nam throws' ->
        expect(-> new Loader 7).to.throw

      specify 'a name is ok' ->
        expect(-> new Loader 'x').to.not.throw

      specify 'obj throws' ->
        expect(-> new Loader {libs: 'x'}, 'blip').to.throw

    context 'valid' ->
      specify 'allow empty obj' ->
        expect(-> new Loader name, name).to.not.throw

  describe 'valid loader' ->
    before-each ->
      loader := new Loader name, './xlibs/components'

    describe 'loader' ->
      specify 'has name set' ->
        expect loader.name .to.equal name

    describe 'valid-config' ->
      specify 'any object is valid' ->
        expect loader.valid-config({}) .to.eql {}

      specify 'any non-object is invalid' ->
        expect (-> loader.valid-config('x')) .to.throw

    describe 'component-file' ->
      specify 'is combined into a local repo file path' ->
        expect loader.component-file! .to.eql './xlibs/components/bootstrap.json'

      specify 'blip is non-existing file path' ->
        expect loader.component-file('blip') .to.eql './xlibs/components/blip.json'

    describe 'has-local' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-local! .to.be.true

    describe 'has-local(name)' ->
      specify 'bootstrap is in local repo' ->
        expect loader.has-local 'bootstrap' .to.be.true

      specify 'blip is not in local repo' ->
        expect loader.has-local 'blip' .to.be.false

    describe 'registry-file' ->
      specify 'is combined into a registry file path' ->
        expect loader.registry-file! .to.eql './xlibs/registry/bootstrap.json'

    describe 'load' ->
      context 'registry config' ->
        specify 'loads config from registry' ->
          expect( -> loader.load './xlibs/registry/bootstrap.json').to.throw

      context 'local config' ->
        specify 'loads config from local repo' ->
          expect loader.load('./xlibs/components/bootstrap.json').dir .to.eql 'dist'

    describe 'loadIt' ->
      context 'from local config' ->
        specify 'loads config from registry' ->
          expect loader.load-it!.dir .to.eql 'dist'


