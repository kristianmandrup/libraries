chai   = require 'chai'
expect = chai.expect

chai-as-promised = require "chai-as-promised"
chai.use chai-as-promised

util = require 'util'

Adaptor = require '../../../../../lib/registry/config/adaptor/bower-adaptor'

log = console.log

describe 'BowerAdapter' ->
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
      adaptor := new Adaptor 'ember-bootstrap'

    describe 'adapt' ->

    describe 'main' ->

    describe 'files' ->

    describe 'has-main' ->

    describe 'main-files' ->

    describe 'bower-json' ->

    describe 'retrieve' ->

    describe 'repo-translator' ->
      # expect adapter.repo-translator .to.be.an.instance-of GithubRepoTranslator

    describe 'repo-uri' ->

    # for now just use first repo
    describe 'repo' ->

    describe 'find-repos' ->

    # http://chaijs.com/plugins/chai-as-promised
    describe 'find(cb)' ->
      specify 'finds bower repo uri' ->
        expect adaptor.find!.promise .to.eventually.eql {type: 'alias', url: 'git://github.com/emberjs-addons/ember-bootstrap.git'}
