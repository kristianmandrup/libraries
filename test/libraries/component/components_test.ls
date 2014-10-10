/**
 * User: kristianmandrup
 * Date: 07/10/14
 * Time: 23:16
 */

expect = require 'chai' .expect

Components    = require '../../../lib/component/components'
Component     = require '../../../lib/component/component'
ConfigLoader  = require '../../../lib/config/loader'

log = console.log

describe 'Components' ->
  var components

  cmps = {}
  cmps.some = ['bootstrap', 'foundation']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Components).to.throw

      specify 'number throws' ->
        expect(-> new Components 7).to.throw

      specify 'string throws' ->
        expect(-> new Components 'x').to.throw

      specify 'list ok' ->
        expect(-> new Components ['blip']).to.throw


    context 'valid' ->
      specify 'empty list ok' ->
        expect(-> new Components []).to.not.throw

  describe 'valid components' ->
    var components, cmp

    before-each ->
      components  := new Components cmps.some
      cmp         := 'bootstrap'

    # must use factory + registry/finder !?
    describe 'component(name)' ->
      specify 'must be a Component' ->
        expect components.component(cmp, {}) .to.be.an.instance-of Component

    describe 'index(name)' ->
      specify 'strapper not there' ->
        expect components.index('strapper') .to.equal -1

      specify 'bootstrap is there' ->
        expect components.index(cmp) .to.equal 0

    describe 'add-one(name)' ->
      var old-length

      before ->
        old-length := components.list.length
        components.add-one(cmp)

      specify 'doesn not add duplicate' ->
        expect components.list .to.include cmp

      specify 'length is unchanged' ->
        expect components.list.length .to.eql old-length

      describe 'index(name)' ->
        specify 'strapper is there' ->
          expect components.index(cmp) .to.eql 0

    describe 'has(name)' ->
      specify 'strapper is there' ->
        expect components.has(cmp) .to.be.true

    describe 'component(name)' ->
      specify 'is a Component' ->
        expect components.component('bootstrap', {}) .to.be.an.instance-of Component

    describe 'component-object(name)' ->
      specify 'is an Object' ->

    describe 'remove-one(name)' ->
      specify 'removes it' ->
        expect components.remove-one(cmp).list .to.not.include cmp

    describe 'load-listed-components' ->
      specify 'build all configurations' ->
        expect components.load-listed-components!.foundation.dir .to.eql 'dist'

    describe 'config-loader(name)' ->
      var config-loader

      before ->
        config-loader := components.config-loader 'bootstrap', './xlibs/components'

      specify 'is a ConfigLoader' ->
        expect config-loader .to.be.an.instance-of ConfigLoader

      specify 'is configured with name' ->
        expect config-loader.name .to.eql 'bootstrap'

      specify 'is configured with path' ->
        expect config-loader.path .to.eql './xlibs/components'