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
      specify 'gets location' ->
        expect gconf.default-location-of 'components.dir' .to.eql './xlibs/components'

    describe 'location-of' ->
      var config
      before-each ->
        config := {builds: {dir: 'xlibs/build' }}

      specify 'gets location' ->
        expect gconf.location-of('builds.dir', config) .to.eql 'xlibs/build'

    describe 'select.file' ->
      specify 'gets location' ->
        expect gconf.select!file! .to.eql './xlibs/select'

    describe 'builds.dir' ->
      specify 'gets location' ->
        expect gconf.builds!dir! .to.eql './xlibs/builds'

    describe 'components.dir' ->
      specify 'gets location' ->
        expect gconf.components!dir! .to.eql './xlibs/components'

    describe 'components.file' ->
      specify 'gets location' ->
        expect gconf.components!file! .to.eql './xlibs/components/index.json'

    describe 'config.file' ->
      specify 'gets location' ->
        expect gconf.config!file! .to.eql './xlibs/config.json'
