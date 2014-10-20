expect = require 'chai' .expect

Installer = require '../../../../lib/registry/installer/json-installer'

log = console.log

describe 'JsonInstaller' ->
  var installer

  config = {}

  describe 'create' ->
    context 'invalid' ->
      specify 'bad nam throws' ->
        expect(-> new Installer 7).to.throw

    context 'valid' ->
      specify 'name string is ok' ->
        expect(-> new Installer 'x').to.not.throw

      specify 'name, path string ok' ->
        expect(-> new Installer 'x', 'y').to.not.throw

  describe 'valid instance' ->
    var io
    before ->
      io := (msg) ->
        msg

      config.bootstrap := {
        files: ['dist/js/bootstrap.js']
      }

      installer := new Installer 'bs', config.bootstrap, log: io

    describe 'installing' ->
      specify 'displays console install msg' ->
        expect installer.installing! .to.match /installing/

    describe 'uninstalling' ->
      specify 'displays console uninstall msg' ->
        expect installer.uninstalling! .to.match /uninstalling/

    describe 'json' ->
      specify 'returns json of local components file' ->
        expect typeof!(installer.json!) .to.eql 'Object'

    describe 'components' ->
      specify 'returns components entry' ->
        expect typeof!(installer.components!) .to.eql 'Object'

    describe 'stringified' ->
      specify 'returns json as string' ->
        expect installer.stringified! .to.eql "{\"files\":[\"dist/js/bootstrap.js\"]}"

    describe 'install' ->
      before-each ->
        installer.install true

      specify 'installs json of component into components.json' ->
        expect installer.components!.bs .to.eql config.bootstrap

    describe.only 'install and uninstall' ->
      before-each ->
        installer.install true

      specify 'uninstalls bootstrap entry from components.json' ->
        expect installer.components!.bs .to.eql config.bootstrap
        installer.uninstall!
        expect installer.components!.bs .to.eql void
