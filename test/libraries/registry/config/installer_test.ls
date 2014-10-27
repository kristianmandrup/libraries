expect  = require 'chai' .expect
log     = console.log

FileInstaller     = require '../../../../lib/registry/config/installer/file-installer'
JsonInstaller     = require '../../../../lib/registry/config/installer/json-installer'
Installer         = require '../../../../lib/registry/config/installer'

describe 'Installer' ->
  describe 'create(type, args)' ->
    context 'invalid' ->
      specify 'Object arg throws' ->
        expect -> new Installer {x: 2} .to.throw

      specify 'no args fails' ->
        expect -> new Installer .to.throw

    context 'valid' ->

      specify 'string json ok' ->
        expect -> new Installer 'json' .to.not.throw

    context 'default instance' ->
      var installer

      before-each ->
        installer := new Installer 'file', 'bootstrap', ' '

      describe 'type' ->
        specify 'default set to file' ->
          expect installer.type .to.eql 'file'

      describe 'installer' ->
        specify 'default is FileInstaller' ->
          expect installer.installer! .to.be.an.instance-of FileInstaller

      describe 'selected-installer' ->
        specify 'is FileInstaller' ->
          expect installer.selected-installer! .to.eql FileInstaller

    context 'json instance' ->
      var installer

      before-each ->
        installer := new Installer 'json', 'bootstrap', {x: '2'}

      describe 'type' ->
        specify 'default set to file' ->
          expect installer.type .to.eql 'json'

      describe 'installer' ->
        specify 'default is FileInstaller' ->
          expect installer.installer! .to.be.an.instance-of JsonInstaller
