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

      specify 'bad nam throws' ->
        expect(-> new Containers 7).to.throw

      specify 'non-existing file' ->
        expect(-> new Containers 'x').to.not.throw


    context 'valid' ->
      specify 'obj is ok' ->
        expect(-> new Containers {libs: 'x'}).to.not.throw

      specify 'allow empty obj' ->
        expect(-> new Containers {}).to.not.throw

  describe 'valid container' ->
    before-each ->
      containers := new Containers conf.bower
    describe 'container(name)' ->
      specify 'bower is not empty' ->
        expect containers.container('bower') .to.not.be.void

      specify 'vendor has no libs' ->
        expect containers.container('vendor').libs! .to.eql {}

