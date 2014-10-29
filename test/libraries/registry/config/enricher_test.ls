enricher = require '../../../../lib/registry/config/enricher'

LocalComponentAdapter   = require '../../../../lib/registry/config/package/component/local-component'


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
          expect normalizer.enrich! .to.eql {}

      describe 'type' ->
        specify 'set to component' ->
          expect normalizer.type .to.eql 'component'

      describe 'from' ->
        specify 'defaults to local' ->
          expect normalizer.from .to.eql 'local'

      describe 'bad-adapter' ->
        specify 'throws' ->
          expect normalizer.bad-adapter! .to.throw

      describe 'adapter-clazz' ->
        specify 'gets one' ->
          expect normalizer.adapter-clazz! .to.eql LocalComponentAdapter

      describe 'adapter' ->
        specify 'gets one' ->
          expect normalizer.adapter('bootstrap') .to.be.an.instance-of LocalComponentAdapter
