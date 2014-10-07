/**
 * User: kristianmandrup
 * Date: 07/10/14
 * Time: 23:16
 */

expect = require 'chai' .expect

Components = require '../../../lib/component/components'

log = console.log

describe 'Components' ->
  var components

  cmps = {}
  cmps.some = ['bootme', 'foundation']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Components).to.throw

      specify 'number throws' ->
        expect(-> new Components 7).to.throw

      specify 'string throws' ->
        expect(-> new Components 'x').to.throw

    context 'valid' ->
      specify 'empty list ok' ->
        expect(-> new Components []).to.not.throw

      specify 'list ok' ->
        expect(-> new Components ['blip']).to.not.throw


  describe 'valid components' ->
    var components, cmp

    before-each ->
      components  := new Components cmps.some
      cmp         := 'strapper'

    # must use factory + registry/finder !?
    xdescribe 'component(name)' ->
      specify 'must be a Component' ->
        expect components.component('strapper') .to.be.an.instance-of Component

    describe 'index(name)' ->
      specify 'strapper not yet there' ->
        expect components.index(cmp) .to.equal -1

    describe 'add-one(name)' ->
      specify 'adds it' ->
        expect components.add-one(cmp).list .to.include cmp

      describe 'index(name)' ->
        specify 'strapper is there' ->
          expect components.index(cmp) .to.eql 2

    describe 'has(name)' ->
      specify 'strapper is there' ->
        expect components.has(cmp) .to.be.true

    describe 'remove-one(name)' ->
      specify 'removes it' ->
        expect components.remove-one(cmp).list .to.not.include cmp

