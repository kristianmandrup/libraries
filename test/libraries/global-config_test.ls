expect  = require 'chai' .expect
log     = console.log

GlobalConfig = require '../../lib/global-config'

describe 'GlobalConfig' ->
  describe 'create(options)' ->
    specify 'no args is valid' ->
      expect -> new GlobalConfig .to.not.throw

  describe 'instance' ->
    var gconf

    before-each ->
      gconf := new GlobalConfig

    describe 'librariesrc' ->
      specify 'is .librariesrc' ->
        expect gconf.librariesrc .to.eql './.librariesrc'

    describe 'default ...' ->
      specify 'gets location' ->
        expect gconf.default!.components!.dir! .to.eql './xlibs/components'

    describe 'default-location-of' ->
      specify 'gets default components dir' ->
        expect gconf.default-location-of 'components.dir' .to.eql './xlibs/components'

      specify 'gets default registry dir' ->
        expect gconf.default-location-of 'registry.dir' .to.eql './xlibs/registry'

    describe 'location-of' ->
      var config
      before-each ->
        config := {builds: {dir: 'xlibs/build' }}

      specify 'gets builds dir location' ->
        expect gconf.location-of('builds.dir', config) .to.eql 'xlibs/build'

      specify 'can not get registry dir location' ->
        expect gconf.location-of('registry.dir', config) .to.eql void

    describe 'location' ->
      specify 'can not get registry dir location' ->
        expect gconf.location('registry.dir') .to.eql './xlibs/registry'

    describe 'select.file' ->
      specify 'gets location' ->
        expect gconf.location \select.file .to.eql './xlibs/select'

    describe 'builds.dir' ->
      specify 'gets location' ->
        expect gconf.location \builds.dir .to.eql './xlibs/builds'

    describe 'components.dir' ->
      specify 'gets location' ->
        expect gconf.location \components.dir .to.eql './xlibs/components'

    describe 'components.file' ->
      specify 'gets location' ->
        expect gconf.location \components.file .to.eql './xlibs/components/index.json'

    describe 'config.file' ->
      specify 'gets location' ->
        expect gconf.location \config.file .to.eql './xlibs/config.json'

    describe 'registry.dir' ->
      specify 'gets location' ->
        expect gconf.location \registry.dir .to.eql './xlibs/registry'

    describe 'default registry.dir' ->
      specify 'gets location' ->
        expect gconf.default!registry!dir! .to.eql './xlibs/registry'

    describe 'dir-for' ->
      specify 'bower' ->
        expect gconf.dir-for 'bower' .to.eql 'bower_components'

    describe 'find' ->
      specify 'finds obj via path' ->
        expect gconf.find {preferences: 'x'}, 'preferences' .to.eql \x

    describe 'preferences' ->
      specify 'loads all' ->
        expect gconf.preferences!.styles .to.include \css \less \scss \sass
