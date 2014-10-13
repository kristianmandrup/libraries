/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
expect = require 'chai' .expect

Generator   = require '../../../lib/output/generator'
Selector    = require '../../../lib/select/selector'
fs          = require 'fs-extra'

log = console.log

describe 'Generator' ->
  var generator

  cmps = {}
  cmps.some = ['bootstrap', 'foundation']

  describe 'create' ->
    context 'invalid' ->
      specify 'number throws' ->
        expect(-> new Generator 7).to.throw

      specify 'string throws' ->
        expect(-> new Generator 'x').to.throw

      specify 'list throws' ->
        expect(-> new Generator ['blip']).to.throw

    context 'valid' ->
      specify 'no args ok' ->
        expect(-> new Generator).to.not.throw

      specify 'empty obj ok' ->
        expect(-> new Generator {}).to.not.throw

  describe 'valid generator' ->
    before-each ->
      generator  := new Generator

    describe 'selector' ->
      specify 'must be a Selector' ->
        expect generator.selector! .to.be.an.instance-of Selector

    describe 'target-file' ->
      specify 'must be an imports file' ->
        expect generator.target-file! .to.eql 'imports-dev.js'

    describe 'target-path' ->
      specify 'must be an imports path' ->
        expect generator.target-path! .to.eql './xlibs/builds/imports-dev.js'

    describe 'load' ->
      specify 'no build file to load - throws' ->
        expect(-> generator.load!).to.throw

    describe 'build(cb)' ->
      specify 'must build' ->
        expect generator.build! .to.not.be.empty

    describe 'unpacked(cb)' ->
      specify 'must unpack build' ->
        expect generator.unpacked(generator.build!) .to.not.be.empty

    describe 'generate(build, opts)' ->
      var res
      before ->
        res := generator.generate!

      specify 'must generate' ->
        expect fs.readFileSync(res.target-path!) .to.not.eql void

  xcontext 'build' ->
    describe 'load' ->
      var loaded
      before ->
        loaded := generator.load!
      specify 'must load target path' ->
        expect typeof(loaded) .to.eql 'function'

    describe 'unpacked(build)' ->
      var build
      before ->
        build := generator.build!

      specify 'must flatten' ->
        expect generator.unpacked(build) .to.eql ['']

    describe 'wrapped(build)' ->
      specify 'must wrap build' ->
        log generator.wrapped(build)!
        expect generator.wrapped(build)! .to.match /module\.exports/
