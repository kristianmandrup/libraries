expect  = require 'chai' .expect
log     = console.log

Enricher            = require '../../../../lib/registry/config/enricher'
PkgAdapter          = require '../../../../lib/registry/config/package/pkg-adapter'
LocalBowerAdapter   = require '../../../../lib/registry/config/package/bower/local-bower'

describe 'Enricher' ->
  describe 'create(@name, @config, @options = {})' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect -> new Enricher .to.throw

      specify 'string args throws' ->
        expect -> new Enricher 'x' .to.throw

    context 'valid' ->
      specify 'config obj ok' ->
        expect -> new Enricher 'bootstrap', {}, {type: 'bower'} .to.not.throw

    context 'instance' ->
      var enricher

      before-each ->
        enricher := new Enricher {categories: ['ui']}, {type: 'bower', name: 'bootstrap'}

      describe 'enrich' ->
        specify 'enriches config' ->
          enricher.enrich!then (res) ->
            expect res.categories .to.include "ui"
            expect res.files .to.include "less/bootstrap.less"


      describe 'adapted' ->
        before ->
          enricher.adapt!
        specify 'is adapted obj' ->
          expect enricher.adapted! .to.eql {}

      describe 'adapt' ->
        specify 'adapts' ->
          enricher.adapt!then (res) ->
            expect res.files .to.include "less/bootstrap.less"

      describe 'pkg-adapter' ->
        specify 'is a PkgAdapter' ->
          expect enricher.pkg-adapter! .to.be.an.instance-of PkgAdapter

        specify 'uses a LocalBowerAdapter' ->
          expect enricher.pkg-adapter!.adapter! .to.be.an.instance-of LocalBowerAdapter
