// Generated by LiveScript 1.2.0
(function(){
  var Component, toString$ = {}.toString;
  module.exports = Component = (function(){
    Component.displayName = 'Component';
    var prototype = Component.prototype, constructor = Component;
    function Component(name, comp){
      this.name = name;
      this.comp = comp;
      this.validate();
      this.baseDir = this.comp.dir;
      this;
    }
    prototype.validate = function(){
      if (toString$.call(this.name).slice(8, -1) !== 'String') {
        throw new Error("Name of component must be a String");
      }
      if (toString$.call(this.comp).slice(8, -1) !== 'Object') {
        throw new Error("component must be an Object");
      }
    };
    prototype.locationObj = function(){
      var obj, i$, ref$, len$, name, paths;
      obj = {};
      for (i$ = 0, len$ = (ref$ = ['scripts', 'styles', 'sass', 'fonts']).length; i$ < len$; ++i$) {
        name = ref$[i$];
        paths = this.locations(name);
        if (paths) {
          obj[name] = paths;
        }
      }
      return obj;
    };
    prototype.locations = function(type){
      var conf, i$, ref$, len$, file, results$ = [];
      conf = this.comp[type];
      if (!conf) {
        return;
      }
      for (i$ = 0, len$ = (ref$ = conf.files).length; i$ < len$; ++i$) {
        file = ref$[i$];
        results$.push(this.location(conf.dir, file));
      }
      return results$;
    };
    prototype.location = function(dir, file){
      return [this.baseDir, dir, file].filter(function(item){
        return !!item;
      }).join('/');
    };
    return Component;
  }());
}).call(this);