GlobalConfig  = require '../../../global-config'
gconf         = new GlobalConfig
fs            = require 'fs-extra'
exec          = require('child_process').exec
Q = require 'q'

RegistryClient = require 'bower-registry-client'
registry       = new RegistryClient strictSsl: false, timeout: 12000
install        = registry.install
uninstall      = registry.uninstall

module.exports = class PkgInstaller
  (@type, @names) ->
    @validate!
    @

  validate: ->
    unless typeof! @type is \String
      throw Error "Type must be a String, was: #{@type}"

    unless typeof! @names is \Array
      throw Error "Names must be an Array, was: #{@names}"

  install: ->
    deferred = Q.defer!
    command = @["#{@type}Install"]!
    return deferred.promise unless command

    exec command, deferred.make-node-resolver!
    deferred.promise.then (stdout) ~>
      # console.log stdout
      true
    .catch (error) ->
      console.error error
      throw error
    # .done!

  uninstall: (...names) ->
    deferred = Q.defer!
    to-uninstall = names.filter (name) ~>
      @is-installed-pkg name

    return deferred.promise unless to-uninstall.length > 1
    command = @["#{@type}Uninstall"](to-uninstall)

    return deferred.promise unless command

    exec command, deferred.make-node-resolver!
    deferred.promise.then (stdout) ~>
      # console.log stdout
      true
    .catch (error) ->
      console.error error
      throw error
    # .done!


  bower-install: ->
    return if @uninstalled!.length < 1
    "bower install #{@uninstalled-args!} --save-dev"

  bower-uninstall: (names) ->
    names = [names] if typeof names is 'string'
    names = names.join ' '
    "bower uninstall #{names}"

  component-install: ->

  uninstalled-args: ->
    @uninstalled!.join ' '

  uninstalled: ->
    @_uninstalled ||= @names.filter (name) ~>
      @installed!.index-of(name) is -1

  installed: ->
    @_installed ||= @names.filter (name) ~>
      @is-installed-pkg name

  is-installed-pkg: (name) ->
    name = @pkg-name name
    try
      fs.statSync @pkg-dir(name) .is-directory!
    catch
      false

  pkg-name: (name) ->
    repo = name.match /git:\/\/github.com\/(.*)\.git/
    name = repo[1] if repo
    short-repo = name.match /\/(.*)$/
    return short-repo[1] if short-repo
    name

  pkg-dir: (name) ->
    [@container-dir!, name].join '/'

  container-dir: ->
    gconf.dir-for @type
