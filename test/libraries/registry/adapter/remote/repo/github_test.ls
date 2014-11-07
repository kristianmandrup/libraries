expect = require 'chai' .expect

Github   = require '../../../../../../lib/registry/adapter/remote/repo/github'

log = console.log

describe 'Github repo adapter' ->
  var github

  describe 'valid instance' ->
    before ->
      github := new Github

    describe 'registry-path' ->
      specify 'is github path' ->
        expect github.registry-path! .to.eql "https://raw.githubusercontent.com/kristianmandrup/libraries/master/registry"
