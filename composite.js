// Generated by LiveScript 1.2.0
(function(){
  var RemapImporter, LibImporter, Composite;
  RemapImporter = require('./remap-importer');
  LibImporter = require('./lib-importer');
  module.exports = Composite = (function(){
    Composite.displayName = 'Composite';
    var prototype = Composite.prototype, constructor = Composite;
    function Composite(app, directory){
      this.app = app;
      this.directory = directory;
    }
    prototype.importAll = function(values){
      if (values.libs) {
        new LibImporter(this, values.libs).importAll();
      }
      if (values.remap) {
        return new RemapImporter(this, values.remap).importAll();
      }
    };
    return Composite;
  }());
}).call(this);
