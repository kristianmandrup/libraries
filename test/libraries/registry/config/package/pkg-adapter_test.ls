expect  = require 'chai' .expect
log     = console.log

PkgAdapter          = require '../../../../../lib/registry/config/package/pkg-adapter'
LocalBowerAdapter   = require '../../../../../lib/registry/config/package/bower/local-bower'

describe 'PkgAdapter' ->
  describe 'create(@options = {})' ->
#    @type = @options.type or 'bower'
#    @from = @options.from or 'local'
#    @name = options.name

#  validate: ->
#    unless typeof! @type is 'String'
#      throw new Error "Type must be a String, was: #{@type}"
#
#    unless typeof! @from is 'String'
#      throw new Error "From must be a String, was: #{@from}"

  context 'init' ->
    var pkg-adapter

    before-each ->
      pkg-adapter := new PkgAdapter name: 'bootstrap', type: 'bower'

    describe 'adapt(name)' ->
      specify 'is an Adapter' ->
        pkg-adapter.adapt!then (res) ->
          expect res.files .to.include "less/bootstrap.less"

    describe 'adapter(name)' ->
      specify 'is an Adapter' ->
        expect pkg-adapter.adapter! .to.be.an.instance-of LocalBowerAdapter


    describe 'adapter-clazz' ->
      specify 'is an Adapter class' ->
        expect pkg-adapter.adapter-clazz! .to.equal LocalBowerAdapter
