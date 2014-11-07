// Generated by LiveScript 1.2.0
(function(){
  var GlobalConfig, gconf, BasicRegistryAdapter, toString$ = {}.toString;
  GlobalConfig = require('../../global-config');
  gconf = new GlobalConfig;
  module.exports = BasicRegistryAdapter = (function(){
    BasicRegistryAdapter.displayName = 'BasicRegistryAdapter';
    var prototype = BasicRegistryAdapter.prototype, constructor = BasicRegistryAdapter;
    function BasicRegistryAdapter(options){
      this.options = options != null
        ? options
        : {};
      this.type || (this.type = this.options.type || this.defaultType());
      this.installerType = this.options.installer || this.defaultInstaller();
      this.adapterType = this.options.adapter || this.defaultAdapter();
      BasicRegistryAdapter.superclass.apply(this, arguments);
      this.validate();
      this;
    }
    prototype.defaultType = function(){
      return gconf.get('registry.adapter.type') || 'bower';
    };
    prototype.defaultInstaller = function(){
      return gconf.get('registry.adapter.installer') || 'json';
    };
    prototype.defaultAdapter = function(){
      return gconf.get('registry.adapter.name') || 'pkg';
    };
    prototype.validate = function(){
      if (toString$.call(this.type).slice(8, -1) !== 'String') {
        throw Error("Type must be a String, was: " + this.type);
      }
      if (toString$.call(this.adapterType).slice(8, -1) !== 'String') {
        throw Error("adapter type must be a String, was: " + this.adapterType);
      }
    };
    prototype.load = function(){
      return this.adapter().load();
    };
    prototype.install = function(){
      return this.adapter().install(this.installerType);
    };
    prototype.adapter = function(){
      var clazz;
      clazz = this.selectedAdapter();
      return new clazz(this.options);
    };
    prototype.selectedAdapter = function(){
      return this.adapter[this.adapterType] || this.badAdapter();
    };
    prototype.badAdapter = function(){
      throw new Error("unknown adapter " + this.adapterType);
    };
    return BasicRegistryAdapter;
  }());
}).call(this);