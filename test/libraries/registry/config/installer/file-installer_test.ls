expect = require 'chai' .expect

Installer = require '../../../../lib/registry/installer/file-installer'

log = console.log

describe 'FileInstaller' ->
  var installer

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

      installer := new Installer 'bootstrap', ' ', 'bootstrap.json', log: io

    describe 'installing' ->
      specify 'displays console install msg' ->
        expect installer.installing! .to.match /installing/

    describe 'uninstalling' ->
      specify 'displays console uninstall msg' ->
        expect installer.uninstalling! .to.match /uninstalling/