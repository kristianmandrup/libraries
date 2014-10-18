Loader = require './loader'


module.exports = class LocalConfigLoader extends BaseConfigLoader
  (@name, @path, @options = {}) ->
    super ...
    @validate!
    @

  loader: ->
    new Loader 'file', @name, @path, @options

  load: ->
    @loader!.load!