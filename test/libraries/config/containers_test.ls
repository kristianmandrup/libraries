/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 10:23
 */
expect = require 'chai' .expect

Containers = require '../../../lib/config/containers'

log = console.log

describe 'Containers' ->
  var containers, conf

  conf = {}

  conf.bower =
    libs: {datepicker: "blip", 'ember-validations': "dist/ember-validations"}
    components: ['bootstrap']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Containers).to.throw

      specify 'number throws' ->
        expect(-> new Containers 7).to.throw

      specify 'string throws' ->
        expect(-> new Containers 'x').to.throw

      specify 'single obj throws' ->
        expect(-> new Containers {}).to.throw

      specify 'obj and string throws' ->
        expect(-> new Containers {}, 'x').to.throw

    context 'valid' ->
      specify 'obj and obj is ok' ->
        expect(-> new Containers {libs: 'x'}, {}).to.not.throw

  describe 'valid containers' ->
    before-each ->
      containers := new Containers conf.bower, conf

    describe 'container(name)' ->
      specify 'bower is not empty' ->
        expect containers.container('bower') .to.not.be.void

      specify 'vendor has no libs' ->
        expect containers.container('vendor').libs! .to.eql {}

