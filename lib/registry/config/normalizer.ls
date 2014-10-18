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

BowerAdapter      = require 'bower-adapter'
ComponentAdapter  = require 'component-adapter'

module.exports = class ConfigNormalizer
  (@config, @type = 'bower') ->
    @validate!

  validate: ->
    unless typeof! @config is 'Object'
      throw new Error "Config to normalize must be an Object, was: #{@config}"

  normalize: ->

  adapter: ->
    @adapters[@type] or @bad-adapter!

  bad-adapter: ->
    @error "Adapter for #{@type} has not been registered"

  error: (msg) ->
    console.error msg

  adapters:
    bower: BowerAdapter
    component: BowerAdapter
