// Generated by LiveScript 1.2.0
(function(){
  var FileIO, Registry, fs, util, ComponentConfig, toString$ = {}.toString;
  FileIO = require('../file-io');
  Registry = require('../registry/registry');
  fs = require('fs');
  util = require('util');
  module.exports = ComponentConfig = (function(){
    ComponentConfig.displayName = 'ComponentConfig';
    var options, prototype = ComponentConfig.prototype, constructor = ComponentConfig;
    importAll$(prototype, arguments[0]);
    function ComponentConfig(name, path){
      this.name = name;
      this.path = path;
      this.validate();
      this;
    }
    prototype.validate = function(){
      if (toString$.call(this.name).slice(8, -1) !== 'String') {
        throw new Error("Name of config to load must be a String, was: " + this.name);
      }
      if (toString$.call(this.path).slice(8, -1) !== 'String') {
        throw new Error("Name of path to load from must be a String, was: " + this.path);
      }
    };
    prototype.loadIt = function(){
      return this.validConfig(this.loadConfig());
    };
    prototype.build = function(){};
    prototype.install = function(options){
      options == null && (options = {});
      if (shouldInstall(options)) {
        return this.registry().install(this.name);
      }
    };
    shouldInstall(options = {})(function(){
      return options.force || this.notLocal();
    });
    prototype.validConfig = function(config){
      if (toString$.call(config).slice(8, -1) === 'Object') {
        return config;
      }
      throw new Error("Invalid config for component " + this.name + ", was: " + util.inspect(config));
    };
    prototype.loadConfig = function(){
      return this.loadFromLocal() || this.loadFromRegistry() || this.none();
    };
    prototype.loadFromLocal = function(){
      if (this.hasLocal()) {
        return this.load(this.componentFile());
      }
    };
    prototype.loadFromRegistry = function(){
      if (this.registry().has(this.name)) {
        return this.load(this.registryFile());
      }
    };
    prototype.registry = function(){
      return this._registry || (this._registry = new Registry);
    };
    prototype.load = function(filePath){
      var err;
      try {
        return this.json(filePath);
      } catch (e$) {
        err = e$;
        return console.error(err);
      }
    };
    prototype.notLocal = function(name){
      return !this.hasLocal(name);
    };
    prototype.hasLocal = function(name){
      name || (name = this.name);
      return this.exists(this.componentFile(name));
    };
    prototype.none = function(){
      return this.error("No Component config for " + this.name + " could be found in local or global component configuration registries");
    };
    prototype.registryFile = function(){
      return this.registry().configFile(this.name);
    };
    prototype.componentFile = function(name){
      name || (name = this.name);
      return [this.path, name + ".json"].join('/');
    };
    prototype.error = function(msg){
      return console.error(msg);
    };
    return ComponentConfig;
  }(FileIO));
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
}).call(this);