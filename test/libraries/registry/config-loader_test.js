// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 12/10/14
 * Time: 12:45
 */
(function(){
  var expect, ConfigLoader, RemoteConfigLoader, LocalConfigLoader, log;
  expect = require('chai').expect;
  ConfigLoader = require('../../../lib/registry/config-loader');
  RemoteConfigLoader = require('../../../lib/registry/config-loader/remote');
  LocalConfigLoader = require('../../../lib/registry/config-loader/local');
  log = console.log;
  describe('ConfigLoader', function(){
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
      describe('local', function(){
        return specify('is LocalConfigLoader', function(){
          return expect(loader.local()).to.be.an.instanceOf(LocalConfigLoader);
        });
      });
      describe('remote', function(){
        return specify('is RemoteConfigLoader', function(){
          return expect(loader.remote()).to.be.an.instanceOf(RemoteConfigLoader);
        });
      });
      return describe('none-loaded', function(){
        return specify('displays error', function(){
          return expect(loader.noneLoaded()).to.eql(void 8);
        });
      });
    });
  });
}).call(this);
