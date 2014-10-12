/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 10:23
 */
expect = require 'chai' .expect

Containers  = require '../../../lib/config/containers'
Container   = require '../../../lib/config/container'

log = console.log

describe 'Containers' ->
  var containers, conf

  conf = {
    bower:
      libs: {datepicker: "blip", 'ember-validations': "dist/ember-validations.js"}
      components: ['bootstrap']
    vendor:
      libs: {moment: 'momentjs.js'}
  }

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
      containers := new Containers conf, {}

    describe 'container(name)' ->
      specify 'bower is not empty' ->
        expect containers.container('bower') .to.not.be.void

      specify 'vendor has no libs' ->
        expect containers.container('vendor').libs! .to.eql {"moment": "momentjs.js"}

    describe 'all' ->
      specify 'list of Container' ->
        expect containers.all!.0 .to.be.an.instance-of Container

    describe 'build' ->
      specify 'builds' ->
        expect containers.build! .to.not.be.void

