PathShortener = require '../../../../lib/registry/config/normalizer/path-shortener'

describe 'PathShortener' ->

  config = {}
  config.simple =
    main:
      files: ['dist/js/bootstrap.js']
    scripts:
      dir: 'dist/js'
      files: ['bootstrap.js']

  describe 'create(config)' ->

  context 'instance' ->
    var shortener

    before-each ->
      shortener := new PathShortener config.simple

    describe 'shorten-paths' ->
      specify 'shortens all paths' ->
        expect shortener.shortener! .to.eql 'bootstrap.js'

    # can be reused at at lv with files
    describe 'shorten-paths-for(entry)' ->

    describe 'shorten-path(file)' ->

