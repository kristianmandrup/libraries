chai   = require 'chai'
expect = chai.expect

chai-as-promised = require "chai-as-promised"
chai.use chai-as-promised

util = require 'util'

Adaptor     = require '../../../../../lib/registry/config/adaptor/component-adaptor'

log = console.log

logx = (msg) ->
  console.log util.inspect(msg)

describe 'ComponentAdapter' ->
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
      adaptor := new Adaptor 'datastore'

    describe 'find' ->
      @timeout 12000
      specify 'find component packages' ->
        adaptor.find!.promise.then (pkgs) ->
          expect pkgs.length .to.eql 1

    describe 'retrieve' ->
      @timeout 4000
      specify 'configure using first pkg' ->
        adaptor.retrieve!.then ->
          expect adaptor.adapted.main.files .to.eql 'index.js'
          expect adaptor.adapted.scripts.files .to.eql ['index.js']
