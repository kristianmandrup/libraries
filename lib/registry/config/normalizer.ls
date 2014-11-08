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

ConfigNormalizer          = require './normalizer/config-normalizer'

# Takes a config object such as a Bower or Component configuration and normalizes it to the
# Library config format using ConfigNormalizer

# Not yet sure if it should deal with adapters or if that should be controlled and passed in from the outside
module.exports = class Normalizer
  (@config, @options = {}) ->
    @validate!
    @

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to normalize must be an Object, was: #{@config}"

  should-normalize: ->
    @config['dir'] is void

  keys: ->
    @_keys ||= Object.keys @config

  # only normalize if we really should
  normalize: (force) ->
    @config = @config-normalizer!.normalize! if @should-normalize! or force
    @config

  config-normalizer: ->
    new ConfigNormalizer @config



