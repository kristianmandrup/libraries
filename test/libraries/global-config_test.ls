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
