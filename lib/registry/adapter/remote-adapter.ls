UriAdapter  = require './remote/uri-adapter'

BasicRegistryAdapter = require './basic-adapter'

module.exports = class RemoteRegistryAdapter extends BasicRegistryAdapter
  (@options = {}) ->
    super ...

  adapters:
    uri:  UriAdapter
