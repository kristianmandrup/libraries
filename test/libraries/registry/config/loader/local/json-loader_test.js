// Generated by LiveScript 1.2.0
(function(){
  var expect, ConfigLoader, log;
  expect = require('chai').expect;
  ConfigLoader = require('../../../../../../lib/registry/config/loader/local/json-loader');
  log = console.log;
  describe('JsonLoader', function(){
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
    return describe('valid instance', function(){
      before(function(){
        return loader = new ConfigLoader('bootstrap');
      });
      describe('load-config', function(){
        return specify('loads config', function(){
          return expect(loader.loadConfig().dir).to.eql('dist');
        });
      });
      describe('has-config', function(){
        specify('has bootstrap', function(){
          return expect(loader.hasConfig('bootstrap')).to.be['true'];
        });
        return specify('does not have blip', function(){
          return expect(loader.hasConfig('blip')).to.be['false'];
        });
      });
      describe('list', function(){
        specify('has 2 entries', function(){
          return expect(loader.list().length).to.eql(2);
        });
        return specify('has a bootstrap entry', function(){
          return expect(loader.list()).to.include("bootstrap");
        });
      });
      describe('json-config', function(){
        return specify('loads json for config', function(){
          return expect(loader.jsonConfig()).to.be.an('Object');
        });
      });
      return describe('config-file', function(){
        return specify('is components/index.json', function(){
          return expect(loader.configFile()).to.eql('./xlibs/components/index.json');
        });
      });
    });
  });
}).call(this);
