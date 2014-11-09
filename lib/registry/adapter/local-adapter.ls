FileAdapter = require './local/file-adapter'
PkgAdapter  = require './local/pkg-adapter'

BasicRegistryAdapter = require './basic-adapter'

# TODO: use global config
module.exports = class LocalRegistryAdapter extends BasicRegistryAdapter
  (@options = {}) ->
    super ...
    @

  adapters:
    file: FileAdapter
    pkg:  PkgAdapter
