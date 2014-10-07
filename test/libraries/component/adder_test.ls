expect = require 'chai' .expect

Component = require '../../../lib/component/component'

describe 'Adder' ->
  var component, comp

  conf = {}

  conf.bootstrap =
    dir: 'dist'
    scripts:
      files: ['js/bootstrap.js']

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Component).to.throw

      specify 'bad nam throws' ->
        expect(-> new Component 7).to.throw

      specify 'no obj throws' ->
        expect(-> new Component 'x').to.throw

    context 'valid' ->
      specify 'name and obj :)' ->
        expect(-> new Component 'x', {}).to.not.throw

  describe 'valid component' ->
