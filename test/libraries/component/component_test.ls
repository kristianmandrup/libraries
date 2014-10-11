/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Component = require '../../../lib/component/component'

describe 'Component' ->
  var component, comp

  conf = {}

  conf.bootstrap =
    dir: 'dist'
    scripts:
      files: ['js/bootstrap.js']
    styles:
      files: ['css/bootstrap.css']

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
    before-each ->
      component := new Component 'bootstrap', conf.bootstrap

    describe 'name' ->
      specify 'is set' ->
        expect component.name .to.eql 'bootstrap'

    describe 'comp' ->
      specify 'is set' ->
        expect component.comp .to.eql conf.bootstrap

    describe 'base-dir' ->
      specify 'is set' ->
        expect component.base-dir .to.eql conf.bootstrap.dir

    describe 'location (dir, file)' ->
      specify 'full script path' ->
        expect component.location('js', 'bootstrap.js') .to.eql "dist/js/bootstrap.js"

    describe 'locations' ->
      specify 'for scripts -> full script paths' ->
        expect component.locations('scripts') .to.eql ["dist/js/bootstrap.js"]

      specify 'for styles -> full styles paths' ->
        expect component.locations('styles') .to.eql ["dist/css/bootstrap.css"]

    describe 'location-obj' ->
      specify 'for all -> full script paths' ->
        expect component.location-obj! .to.eql {
          scripts: ["dist/js/bootstrap.js"]
          styles: ["dist/css/bootstrap.css"]
        }

    describe 'build' ->
      specify 'builds imports' ->
        expect component.build! .to.eql ["app.import('dist/js/bootstrap.js');", "app.import('dist/css/bootstrap.css');"]

      specify 'first import is js' ->
        expect component.build!.0 .to.eql "app.import('dist/js/bootstrap.js');"

