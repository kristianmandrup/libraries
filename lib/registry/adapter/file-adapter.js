// Generated by LiveScript 1.2.0
(function(){
  var FileIO, Installer, BaseAdapter, fs, RegistryFileAdapter;
  FileIO = require('../../file-io');
  Installer = require('../installer');
  BaseAdapter = require('./base-adapter');
  fs = require('fs-extra');
  module.exports = RegistryFileAdapter = (function(superclass){
    var prototype = extend$((import$(RegistryFileAdapter, superclass).displayName = 'RegistryFileAdapter', RegistryFileAdapter), superclass).prototype, constructor = RegistryFileAdapter;
    importAll$(prototype, arguments[1]);
    function RegistryFileAdapter(options){
      this.options = options != null
        ? options
        : {};
      this.registryUri = this.options.registry || './xlibs/registry';
      this.localRegistryPath = this.options.local || './xlibs/components';
      this.validate();
      this;
    }
    prototype.installer = function(){
      return this._installer || (this._installer = new Installer);
    };
    prototype.install = function(name){
      return this.installer.install({
        source: this.readConfig(name),
        target: this.targetConfig(name)
      });
    };
    prototype.readConfig = function(name){
      return fs.readFileSync(this.configFile(name));
    };
    prototype.indexFile = function(){
      return [this.registryUri, 'index.json'].join('/');
    };
    prototype.index = function(){
      return this._index || (this._index = this.json(this.indexFile()));
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
    return RegistryFileAdapter;
  }(BaseAdapter, FileIO));
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
}).call(this);