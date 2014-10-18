// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 17/10/14
 * Time: 20:31
 */
(function(){
  var FileIO, Installer, BaseAdapter, toString$ = {}.toString;
  FileIO = require('../../file-io');
  Installer = require('../installer');
  module.exports = BaseAdapter = (function(){
    BaseAdapter.displayName = 'BaseAdapter';
    var prototype = BaseAdapter.prototype, constructor = BaseAdapter;
    importAll$(prototype, arguments[0]);
    function BaseAdapter(options){
      this.options = options != null
        ? options
        : {};
      this.registryUri || (this.registryUri = this.options.registry);
      this.localRegistryPath = this.options.local || './xlibs/components';
      this.validate();
      this;
    }
    prototype.validate = function(){
      if (toString$.call(this.registryUri).slice(8, -1) !== 'String') {
        throw new Error("registryUri must be a String");
      }
      if (toString$.call(this.localRegistryPath).slice(8, -1) !== 'String') {
        throw new Error("localRegistryPath must be a String, was " + this.localRegistryPath);
      }
    };
    prototype.installer = function(){
      return this._installer || (this._installer = new Installer(this.options.installer));
    };
    prototype.list = function(){
      return this._list || (this._list = this.index().registry);
    };
    prototype.has = function(name){
      return this.list().indexOf(name) > -1;
    };
    prototype.configFile = function(name){
      return [this.registryUri, name + ".json"].join('/');
    };
    prototype.targetConfig = function(name){
      return [this.localRegistryPath, name + ".json"].join('/');
    };
    prototype.error = function(msg){
      return console.error(msg);
    };
    return BaseAdapter;
  }(FileIO));
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
}).call(this);