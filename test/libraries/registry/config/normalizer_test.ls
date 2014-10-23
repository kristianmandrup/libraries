expect  = require 'chai' .expect
log     = console.log

Normalizer              = require '../../../../lib/registry/config/normalizer'
LocalComponentAdapter   = require '../../../../lib/registry/config/package/component/local-component'
FilesNormalizer         = require '../../../../lib/registry/config/normalizer/files-normalizer'

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

    context 'instance' ->
      var normalizer

      before-each ->
        normalizer := new Normalizer {}, {type: 'component'}

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
          expect normalizer.adapter! .to.be.an.instance-of LocalComponentAdapter

      describe 'files-normalizer' ->
        specify 'creates one' ->
          expect normalizer.files-normalizer! .to.be.an.instance-of FilesNormalizer



#  normalize: ->
#    @files-normalizer!.normalize!
#
#  files-normalizer: ->
#    new FilesNormalizer @config
#
#  adapter: ->
#    @adapters[@from][@type] or @bad-adapter!
#
#  bad-adapter: ->