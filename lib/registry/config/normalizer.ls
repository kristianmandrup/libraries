# Normalize a json structure into a library component config

# bootstrap: {
#  files: ['dist/js/bootstrap.js', 'dist/css/bootstrap.css']}
# }
#
# normalized to
#
# bootstrap: {
#  dir: 'dist'
#  script:
#    dir 'js'
#    files ['bootstrap.js']
#  styles:
#    dir 'css'
#    files ['bootstrap.css']
# }
#
# It should also consult the bower.json of the library via bower search api, and check the "main" property
# and use it as default if there

LocalBowerAdapter         = require './package/bower/local-bower'
RemoteBowerAdapter        = require './package/bower/remote-bower'

RemoteComponentAdapter    = require './package/component/remote-component'
LocalComponentAdapter     = require './package/component/local-component'

ConfigNormalizer          = require './normalizer/config-normalizer'

# Takes a config object such as a Bower or Component configuration and normalizes it to the
# Library config format using ConfigNormalizer

# Not yet sure if it should deal with adapters or if that should be controlled and passed in from the outside
module.exports = class Normalizer
  (@config, @options = {}) ->
    @type = @options.type or 'bower'
    @from = @options.from or 'local'
    @validate!

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to normalize must be an Object, was: #{@config}"

  normalize: ->
    @config-normalizer!.normalize!

  config-normalizer: ->
    new ConfigNormalizer @config

  adapter: (name)->
    clazz = @adapter-clazz!
    new clazz name

  adapter-clazz: ->
    @adapters[@from][@type] or @bad-adapter!

  bad-adapter: ->
    @error "Adapter #{@from} for #{@type} has not been registered"

  error: (msg) ->
    console.error msg

  adapters:
    local:
      bower:      LocalBowerAdapter
      component:  LocalComponentAdapter
    remote:
      bower:      RemoteBowerAdapter
      component:  RemoteComponentAdapter

