expect = require 'chai' .expect

ConfigLoader      = require '../../../../../lib/registry/config/loader/local-loader'
CompositeLoader   = require '../../../../../lib/registry/config/loader/local/composite-loader'
Normalizer        = require '../../../../../lib/registry/config/normalizer'

log = console.log

describe 'LocalConfigLoader' ->
  config =
    files:  ['dist/js/bootstrap.json']

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
    var loader

    before-each ->
      loader := new ConfigLoader 'bootstrap'

    describe 'load-config' ->
      specify 'loads config' ->
        expect loader.config-file!.dir .to.eql 'dist'

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

    describe 'selected-loader' ->
      specify 'selects a loader' ->
        expect loader.selected-loader! .to.eql CompositeLoader

    describe 'loaders' ->
      specify 'selects a loader' ->
        expect Object.keys(loader.loaders!) .to.include 'composite'

    describe 'normalize' ->
      specify 'normalizes a loader' ->
        expect loader.normalize(config) .to.include 'composite'

    describe 'normalizer' ->
      specify 'normalizes a loader' ->
        expect loader.normalizer(config) .to.be.an.instance-of Normalizer

    describe 'loaded-config' ->
      var conf
      before ->
        conf := loader.loaded-config!

      specify 'dir is dist' ->
        expect conf.dir .to.eql 'dist'

      specify 'fonts files has eof and svg' ->
        expect conf.fonts.files .to.include 'bootstrap.eof' #, 'bootstrap.svg'

    describe 'adapter' ->
      specify 'is an Adapter' ->
        expect loader.loader! .to.be.an.instance-of CompositeLoader
