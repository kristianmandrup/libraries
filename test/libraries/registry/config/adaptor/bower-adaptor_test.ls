expect = require 'chai' .expect

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

  describe 'find(cb)' ->