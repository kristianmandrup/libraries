expect = require 'chai' .expect

Translator = require '../../../../../../lib/registry/config/adaptor/bower/github-repo-translator'

log = console.log

describe 'GithubRepoTranslator' ->
  describe 'create(@repo-uri)' ->
    describe 'invalid' ->
      specify 'no args throws' ->
        expect -> new Translator .to.throw

    describe 'valid' ->
      specify 'string arg - ok' ->
        expect(-> new Translator 'x').to.not.throw

  context 'instance' ->
    var translator

    before-each ->
      translator := new Translator 'angularjs-share git://github.com/wlepinski/angularjs-share.git'

    describe 'extract-repo' ->
      specify 'extracts repo account and name' ->
        expect translator.extract-repo! .to.include 'wlepinski'

    describe 'repo-account' ->
      specify 'gets it' ->
        expect translator.repo-account! .to.eql 'wlepinski'

    describe 'repo-name' ->
      specify 'gets it' ->
        expect translator.repo-name! .to.eql 'angularjs-share'

    describe 'translate' ->
      specify 'translates to raw' ->
        expect translator.translate! .to.eql "https://raw.githubusercontent.com/wlepinski/angularjs-share/master/bower.json"