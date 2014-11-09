expect  = require 'chai' .expect
log     = console.log
util    = require 'util'
inspect = (obj) ->
  log util.inspect(obj)

Normalizer              = require '../../../../lib/registry/config/normalizer'
ConfigNormalizer        = require '../../../../lib/registry/config/normalizer/config-normalizer'

describe 'Normalizer' ->
  describe 'create(@config, @options = {})' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect -> new Normalizer .to.throw

      specify 'string args throws' ->
        expect -> new Normalizer 'x' .to.throw

    context 'valid' ->
      specify 'config obj ok' ->
        expect -> new Normalizer {}, {type: 'component'} .to.not.throw

    describe 'should-normalize' ->
      var normalizer, config

      context 'no dir' ->
        before-each ->
          normalizer := new Normalizer {files: ['x/y.js']}, {type: 'component'}

        specify 'it should' ->
          expect normalizer.should-normalize! .to.be.true

      context 'has a dir' ->
        before-each ->
          normalizer := new Normalizer {dir: \x, scripts: ['y.js']}, {type: 'component'}

        specify 'it should not' ->
          expect normalizer.should-normalize! .to.be.false

    context 'instance' ->
      var normalizer, config

      before-each ->
        config :=
          files: ['x/y/z.js']

        normalizer := new Normalizer config, {type: 'component'}

      describe 'config-normalizer' ->
        specify 'creates one' ->
          expect normalizer.config-normalizer! .to.be.an.instance-of ConfigNormalizer

      describe 'keys' ->
        specify 'has one' ->
          expect normalizer.keys! .to.eql ['files']

      describe 'normalize' ->
        specify 'has one' ->
          expect normalizer.normalize! .to.eql {
            dir: 'x'
            scripts: {
              dir: 'y',
              files: ['z.js']
            }
          }
