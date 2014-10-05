// Generated by LiveScript 1.2.0
(function(){
  var fs, FileIO;
  fs = require('fs');
  FileIO = require('./file-io');
  module.exports = {
    readLibs: function(){
      return fs.readFileSync(this.file, 'utf8');
    },
    save: function(file){
      file || (file = this.file);
      fs.writeFileSync(file, JSON.stringify(this.libs, null, '  '));
      return this;
    },
    load: function(){
      this.libs = JSON.parse(this.readLibs());
      return this;
    },
    libs: function(){
      this.libs = JSON.parse(this.readLibs());
      return this;
    },
    print: function(io){
      io == null && (io = console.log);
      io(this.libs);
      return this;
    }
  };
}).call(this);