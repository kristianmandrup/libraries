// Generated by LiveScript 1.2.0
(function(){
  var Q, util, BaseComponentAdapter, toString$ = {}.toString;
  Q = require('q');
  util = require('util');
  module.exports = BaseComponentAdapter = (function(){
    BaseComponentAdapter.displayName = 'BaseComponentAdapter';
    var prototype = BaseComponentAdapter.prototype, constructor = BaseComponentAdapter;
    function BaseComponentAdapter(name, options){
      this.name = name;
      this.options = options != null
        ? options
        : {};
      this.validate();
      if (this.options.repo) {
        this.repos.push(this.options.repo);
      }
      this;
    }
    prototype.validate = function(){
      if (toString$.call(this.name).slice(8, -1) !== 'String') {
        throw new Error("Name of bower component must be a String, was: " + util.inspect(this.name));
      }
    };
    prototype.adapted = {
      main: {},
      scripts: {},
      styles: {},
      fonts: {},
      images: {},
      files: {}
    };
    prototype.configure = function(pkg){
      var key, results$ = [];
      for (key in this.adapted) {
        if (pkg[key]) {
          results$.push(this.adapted[key].files = pkg[key]);
        }
      }
      return results$;
    };
    prototype.retrieve = function(){
      var this$ = this;
      return this.find().promise.then(function(pkgs){
        return this$.configure(pkgs[0]);
      });
    };
    prototype.find = function(){
      var deferred;
      deferred = Q.defer();
      registry.search(this.query(), deferred.makeNodeResolver());
      return deferred;
    };
    return BaseComponentAdapter;
  }());
}).call(this);