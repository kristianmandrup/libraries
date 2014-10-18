// Generated by LiveScript 1.2.0
(function(){
  var expect, FileNormalizer, log, slice$ = [].slice;
  expect = require('chai').expect;
  FileNormalizer = require('../../../../lib/registry/config/normalizer/file-normalizer');
  log = console.log;
  describe('FileNormalizer', function(){
    var loader;
    describe('create', function(){
      context('invalid', function(){
        return specify('bad nam throws', function(){
          return expect(function(){
            return new ConfigLoader(7);
          }).to['throw'];
        });
      });
      return context('valid', function(){
        specify('name string is ok', function(){
          return expect(function(){
            return new ConfigLoader('x');
          }).to.not['throw'];
        });
        return specify('name, path string ok', function(){
          return expect(function(){
            return new ConfigLoader('x', 'y');
          }).to.not['throw'];
        });
      });
    });
    describe('valid instance', function(){
      return before(function(){
        return loader = new FileNormalizer('foundation');
      });
    });
    return {
      normalize: function(){
        var i$, ref$, len$, file, root;
        if (!this.files) {
          return this.config;
        }
        for (i$ = 0, len$ = (ref$ = this.files).length; i$ < len$; ++i$) {
          file = ref$[i$];
          this.normalizeOne(file);
        }
        root = this.findRootPath(path.dirname(file[0]));
        if (!isBlank(root)) {
          this.normalized.dir = root;
          return this.shortenPaths();
        }
      },
      shortenPaths: function(){
        var key, results$ = [];
        for (key in this.normalized) {
          results$.push(shortenPathsFor(this.normalized[key]));
        }
        return results$;
      },
      shortenPathsFor: function(entry){
        var shortenedFiles, i$, ref$, len$, file;
        shortenedFiles = [];
        for (i$ = 0, len$ = (ref$ = entry.files).length; i$ < len$; ++i$) {
          file = ref$[i$];
          shortened.push(this.shortenPath(file));
        }
        return this.normalized[key].files = shortenedFiles;
      },
      shortenPath: function(file){
        return file.slice(this.normalized.root.length);
      },
      normalized: {
        script: {},
        styles: {},
        fonts: {}
      },
      normalizeOne: function(file){
        var ext, type;
        ext = path.extname(file);
        type = this.findType(ext, file);
        if (type) {
          this.addFile(type, file);
          return this.setDir(type, file);
        }
      },
      findRootPath: function(filePath, lv, root){
        var paths, matchPath, i$, ref$, len$, file;
        lv == null && (lv = 0);
        paths = filePath.split('/');
        matchPath = slice$.call(paths, 0, lv + 1 || 9e9).join('/');
        for (i$ = 0, len$ = (ref$ = this.files).length; i$ < len$; ++i$) {
          file = ref$[i$];
          if (!matchPath.match(/^#{path}/)) {
            return root;
          }
        }
        return this.findRootPath(file, lv + 1, matchPath);
      },
      findType: function(type, file){
        var key, ref$, value;
        for (key in ref$ = this.types) {
          value = ref$[key];
          if (value.indexOf(type) > -1) {
            return key;
          }
        }
        return console.error("Unknown file type: " + type + " for " + file);
      },
      types: {
        script: ['js', 'coffee', 'ls'],
        styles: ['css', 'scss', 'less', 'sass'],
        fonts: ['eof', 'svg']
      },
      addFile: function(type, file){
        var ref$;
        (ref$ = normalized[type]).files || (ref$.files = []);
        return normalized[type].files.push(file);
      },
      setDir: function(type, file){}
    };
  });
}).call(this);
