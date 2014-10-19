// Generated by LiveScript 1.2.0
(function(){
  var PathShortener;
  module.exports = PathShortener = (function(){
    PathShortener.displayName = 'PathShortener';
    var prototype = PathShortener.prototype, constructor = PathShortener;
    function PathShortener(config){
      this.config = config;
    }
    prototype.shortenPaths = function(){
      var key, results$ = [];
      for (key in this.config) {
        results$.push(shortenPathsFor(this.config[key]));
      }
      return results$;
    };
    prototype.shortenPathsFor = function(entry){
      var shortenedFiles, i$, ref$, len$, file;
      shortenedFiles = [];
      for (i$ = 0, len$ = (ref$ = entry.files).length; i$ < len$; ++i$) {
        file = ref$[i$];
        shortened.push(this.shortenPath(file));
      }
      return this.config[key].files = shortenedFiles;
    };
    prototype.shortenPath = function(file){
      return file.slice(this.config.root.length);
    };
    return PathShortener;
  }());
}).call(this);