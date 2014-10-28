chai   = require 'chai'
expect = chai.expect

chai-as-promised = require "chai-as-promised"
chai.use chai-as-promised

util = require 'util'

Adaptor     = require '../../../../../../lib/registry/config/package/bower/local-bower'
Translator  = require '../../../../../../lib/registry/config/package/bower/github-repo-translator'

log = console.log

logx = (msg) ->
  console.log util.inspect(msg)

describe 'LocalBowerAdapter' ->
  describe 'create(@name, @options = {})' ->
    describe 'invalid' ->
      specify 'throws' ->
        expect -> new Adaptor .to.throw

    describe 'valid' ->
      specify 'string arg - ok' ->
        expect -> new Adaptor 'x' .to.not.throw

  context 'instance' ->
    var adaptor

    before-each ->
      adaptor := new Adaptor 'bootstrap'

    describe 'adapt' ->
      specify 'get obj with 7 files' ->
        adaptor.adapt!.then (obj) ->
          expect obj.files.length .to.eql 7

    describe 'files' ->
      specify 'has 7 files' ->
        adaptor.files!.then (files) ->
          expect files.length .to.eql 7

    describe 'has-main' ->
      specify 'gets bower.json body' ->
        adaptor.has-main!.then (has) ->
          expect has .to.be.true

    describe 'main-files' ->
      specify 'gets bower.json body' ->
        adaptor.main-files!.then (files) ->
          expect files .to.include "dist/js/bootstrap.js",

    describe 'bower-json' ->
      specify 'gets bower.json body' ->
        adaptor.bower-json!.then (json) ->
          expect json.name .to.eql 'bootstrap'

    describe 'retrieve' ->
      specify 'gets bower.json body' ->
        expect adaptor.retrieve! .to.eventually.match /getbootstrap/

