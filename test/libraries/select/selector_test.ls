/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */

expect = require 'chai' .expect

Selector = require '../../../lib/select/selector'

log = console.log

describe 'Selector' ->
  var selector, select

  file = {}

  before ->
    select = """
bootstrap
foundation
"""

    file.unknown := 'blip'
    file.select  := '../../xlibs/select'

  describe 'create' ->
    context 'invalid' ->
      specify 'no args throws' ->
        expect(-> new Selector).to.throw

      specify 'bad nam throws' ->
        expect(-> new Selector 7).to.throw

      specify 'no obj throws' ->
        expect(-> new Selector 'x').to.throw

      specify 'when file is a non-existing file' ->
        expect(-> new Selector file: file.unknown).to.throw

    context 'valid' ->
      specify 'when select option is string' ->
        expect(-> new Selector select: select).to.not.throw

      specify 'when file is an existing file' ->
        expect(-> new Selector file: file.select).to.not.throw


  describe 'valid selector' ->
    var lib

    before-each ->
      selector  := new Selector select: select
      lib       := 'strapper'

    specify 'no strapper' ->
      expect selector.lines! .to.not.include lib

    describe 'lines' ->
      specify 'has bootstrap' ->
        expect selector.lines! .to.include 'foundation'

    describe 'add' ->
      specify 'strapper' ->
        selector.add lib
        expect  selector.lines! .to.include lib

      describe 'remove' ->
        specify 'strapper' ->
          expect selector.remove(lib).lines! .to.not.include lib

    describe 'install' ->
      before ->
        selector.uninstall 'foundation'

      specify 'installs selected' ->
        expect selector.install! .to.include 'foundation'

    describe 'build' ->
      specify 'has bootstrap' ->
        expect selector.build! .to.eql []
