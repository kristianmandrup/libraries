chai   = require 'chai'
expect = chai.expect

chai-as-promised = require "chai-as-promised"
chai.use chai-as-promised

util = require 'util'

Adaptor = require '../../../../../lib/registry/config/package/component/local-component'

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
