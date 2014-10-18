// Generated by LiveScript 1.2.0
(function(){
  var BowerAdapter, toString$ = {}.toString;
  module.exports = BowerAdapter = (function(){
    BowerAdapter.displayName = 'BowerAdapter';
    var prototype = BowerAdapter.prototype, constructor = BowerAdapter;
    importAll$(prototype, arguments[0]);
    function BowerAdapter(name, options){
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
    prototype.adapted = {};
    prototype.adapt = function(){
      var i$, ref$, len$, key;
      for (i$ = 0, len$ = (ref$ = ['main', 'scripts', 'styles', 'images', 'fonts', 'files']).length; i$ < len$; ++i$) {
        key = ref$[i$];
        this.adapted[key] = this[key]();
      }
      return this.adapted;
    };
    prototype.main = function(){
      return this.component().main;
    };
    prototype.scripts = BowerAdapter.component().scripts;
    prototype.styles = function(){
      return this.component().styles;
    };
    prototype.images = function(){
      return this.component().images;
    };
    prototype.fonts = function(){
      return this.component().fonts;
    };
    prototype.files = function(){
      return this.component().files;
    };
    return BowerAdapter;
  }(FileIO));
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
}).call(this);