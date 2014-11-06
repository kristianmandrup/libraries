expect  = require 'chai' .expect
log     = console.log

Filter  = require '../../../../lib/registry/config/filter'

describe 'Filter' ->
  config = {}
  config.bs =
    scripts:
      files: ['js/bootstrap.min.js', 'js/bootstrap.js']
    styles:
      files: ['css/bootstrap.less', 'css/bootstrap.css']

  context 'instance' ->
    var filter

    before-each ->
      filter := new Filter config.bs

    describe.only 'filter' ->
      specify 'filters for all prefs' ->
        expect filter.filter! .to.eql {
          scripts:
            files: ['js/bootstrap.js']
          styles:
            files: ['css/bootstrap.less']
        }

    describe 'filter-on(name)' ->
      specify 'filters scripts using prefs' ->
        expect filter.filter-on('scripts') .to.eql ['js/bootstrap.js']

      specify 'filters styles using prefs' ->
        expect filter.filter-on('styles') .to.eql ['css/bootstrap.less']

    describe 'filter-one(files, file)' ->
      specify 'filters files using prefs' ->
        expect filter.filter-one(['css/bootstrap.less', 'css/boot.css', 'css/bootstrap.css'], 'css/bootstrap.css', ['less', 'css']) .to.eql ['css/bootstrap.less', 'css/boot.css']

      specify 'filters away .min.js files' ->
        expect filter.filter-one(['js/bootstrap.min.js', 'js/bootstrap.js'], 'js/bootstrap.js', ['js', 'min.js']) .to.eql ['js/bootstrap.js']

    describe 'filter-pref(files, pref)' ->
      specify 'filters using css ext prefs' ->
        expect filter.filter-pref(['css/bootstrap.less', 'css/bootstrap.css'], ['less', 'css']) .to.eql 'css/bootstrap.less'

      specify 'filters using js extension prefs' ->
        expect filter.filter-pref(['js/bootstrap.min.js', 'js/bootstrap.js'], ['js', 'min.js']) .to.eql 'js/bootstrap.js'

    describe 'same(files, file)' ->
      specify 'matches on same file extension' ->
        expect filter.same(['css/bootstrap.less', 'css/boot.css', 'css/bootstrap.css'], 'css/bootstrap.css') .to.eql ['css/bootstrap.less', 'css/bootstrap.css']

      specify 'matches on same file full extension' ->
        expect filter.same(['js/bootstrap.min.js', 'js/bootstrap.js'], 'js/bootstrap.js') .to.eql ['js/bootstrap.min.js', 'js/bootstrap.js']

    describe 'file-name(file)' ->
      specify 'bootstrap.min.js is just bootstrap' ->
        expect filter.file-name('bootstrap.min.js') .to.eql 'bootstrap'


    describe 'matches(file, pref)' ->
      specify 'matches on same file extension' ->
        expect filter.matches 'js/bootstrap.js', 'js' .to.be.true

      specify 'does not match on diff file extension' ->
        expect filter.matches 'js/bootstrap.js', 'min.js' .to.be.false

      specify 'does not match on diff full file extension' ->
        expect filter.matches 'js/bootstrap.min.js', 'js' .to.be.false

    describe 'config-for(name)' ->
      specify 'gets scripts config' ->
        expect filter.config-for 'scripts' .to.eql files: ['js/bootstrap.min.js', 'js/bootstrap.js']

    describe 'prefs-for(name)' ->
      specify 'gets scripts prefs' ->
        expect filter.prefs-for 'scripts' .to.eql ['js', 'min.js']

      specify 'gets styles prefs' ->
        expect filter.prefs-for 'styles' .to.include 'scss'

    describe 'filter-pref-keys' ->
      specify 'does not match on diff file extension' ->
        expect filter.filter-pref-keys! .to.include 'scripts', 'styles'

    describe 'filter-prefs' ->
      specify 'does not match on diff file extension' ->
        expect filter.filter-prefs!.styles .to.include 'scss', 'sass', 'less', 'css'

    describe 'filter-one' ->
      var files, file

      before-each ->
        file := 'bootstrap.less'
        files := ['bootstrap.css', 'bootstrap.less', 'bootstrap.scss']

      specify 'does not match on diff file extension' ->
        expect filter.filter-one(files, file) .to.eql []
