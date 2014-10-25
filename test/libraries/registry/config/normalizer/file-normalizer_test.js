// Generated by LiveScript 1.2.0
(function(){
  var expect, FileNormalizer, log;
  expect = require('chai').expect;
  FileNormalizer = require('../../../../../lib/registry/config/normalizer/file-normalizer');
  log = console.log;
  describe('FileNormalizer', function(){
    var config;
    config = {};
    config.simple = {
      main: {},
      scripts: {}
    };
    describe('create(@file)', function(){
      describe('invalid', function(){
        return specify('no args invalid', function(){
          return expect(function(){
            return new FileNormalizer.to['throw'];
          });
        });
      });
      return describe('valid', function(){
        return specify('name arg is valid', function(){
          return expect(function(){
            return new FileNormalizer('x');
          }).to['throw'];
        });
      });
    });
    return context('instance', function(){
      var normalizer;
      beforeEach(function(){
        return normalizer = new FileNormalizer(config.simple);
      });
      describe('normalized', function(){
        return specify('js file normalized to scripts entry', function(){
          return expect(normalizer.normalized.scripts).to.eql({});
        });
      });
      describe('normalize(file)', function(){
        beforeEach(function(){
          return normalizer.normalize('dist/js/bootstrap.js');
        });
        specify('js file normalized to script entry', function(){
          return expect(normalizer.normalized.scripts.files).to.include('dist/js/bootstrap.js');
        });
        return xspecify('js dir normalized', function(){
          return expect(normalizer.normalized.scripts.dir).to.eql('dist/js');
        });
      });
      describe('find-type(ext, file)', function(){
        return specify('identifies js as a scripts ext', function(){
          return expect(normalizer.findType('js')).to.eql('scripts');
        });
      });
      describe('extension(file)', function(){
        return specify('.js file is js ext', function(){
          return expect(normalizer.extension('dist/js/bootstrap.js')).to.eql('js');
        });
      });
      describe('types', function(){});
      describe('add-file', function(){
        return specify('js file normalized to script entry', function(){
          return expect(normalizer.addFile('scripts').normalized.scripts.files).to.include('dist/js/bootstrap.js');
        });
      });
      return xdescribe('set-dir', function(){
        return specify('js file normalized to script entry', function(){
          return expect(normalizer.setDir('scripts').normalized.scripts.dir).to.eql('dist/js');
        });
      });
    });
  });
}).call(this);
