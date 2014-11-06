chai   = require 'chai'
expect = chai.expect

log     = console.log

chai-as-promised = require "chai-as-promised"
chai.use chai-as-promised

PkgInstaller        = require '../../../../../lib/registry/config/package/pkg-installer'

describe 'PkgInstaller' ->
  describe 'create(@type, @names)' ->

  context 'valid instance' ->
    var installer

    before-each ->
      installer := new PkgInstaller 'bower', ['bootstrap', 'desandro/masonry', 'foundation']

    describe.only 'install' ->
      @timeout 10000

      before-each ->

      after-each ->
        # clean up

      specify 'installs uninstalled packages' ->
        installer.uninstall 'desandro/masonry', 'foundation' .then ~>
          expect installer.install! .to.eventually.be.true

    describe 'pkg-name(name)' ->
      specify 'extracts from github endpoint' ->
        expect installer.pkg-name 'git://github.com/user/package.git' .to.eql 'package'

      specify 'extracts from github shorthand' ->
        expect installer.pkg-name 'desandro/masonry' .to.eql 'masonry'

      specify 'return normal' ->
        expect installer.pkg-name 'jquery' .to.eql 'jquery'

    describe 'bower-install' ->
      specify 'bower install command' ->
        expect installer.bower-install! .to.eql "bower install desandro/masonry foundation --save-dev"

    describe 'component-install' ->
      specify 'component-install command' ->

    describe 'uninstalled-args' ->
      specify 'args list' ->
        expect installer.uninstalled-args! .to.eql "desandro/masonry foundation"

    describe 'uninstalled' ->
      specify 'finds uninstalled packages' ->
        expect installer.uninstalled! .to.include 'desandro/masonry', 'foundation'

    describe 'installed' ->
      specify 'finds installed packages' ->
        expect installer.installed! .to.include 'bootstrap'

    describe 'is-installed-pkg(name)' ->
      specify 'determine if package is present' ->
        expect installer.is-installed-pkg 'bootstrap' .to.be.true

    describe 'pkg-dir(name)' ->
      specify 'finds package dir' ->
        expect installer.pkg-dir('bootstrap') .to.eql 'bower_components/bootstrap'

    describe 'container-dir' ->
      specify 'finds package container dir' ->
        expect installer.container-dir! .to.eql 'bower_components'
