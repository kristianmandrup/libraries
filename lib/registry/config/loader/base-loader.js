// Generated by LiveScript 1.2.0
(function(){
  var BaseConfigLoader, toString$ = {}.toString;
  module.exports = BaseConfigLoader = (function(){
    BaseConfigLoader.displayName = 'BaseConfigLoader';
    var prototype = BaseConfigLoader.prototype, constructor = BaseConfigLoader;
    function BaseConfigLoader(name, path, options){
      this.name = name;
      this.path = path;
      this.options = options != null
        ? options
        : {};
      this.path || (this.path = './xlibs/components');
      this.validate();
      this;
    }
    prototype.validate = function(){
      if (toString$.call(this.name).slice(8, -1) !== 'String') {
        throw new Error("Name of config to load must be a String, was: " + this.name);
      }
    };
    return BaseConfigLoader;
  }());
}).call(this);