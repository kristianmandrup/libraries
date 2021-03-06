// Generated by LiveScript 1.2.0
(function(){
  var expect, ConfigLoader, log;
  expect = require('chai').expect;
  ConfigLoader = require('../../../../../lib/registry/config/loader/base-loader');
  log = console.log;
  describe('BaseConfigLoader', function(){
    var loader, config;
    config = {
      local: './xlibs/components/bootstrap.json',
      remote: './xlibs/registry/bootstrap.json'
    };
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
      return before(function(){
        loader = new ConfigLoader('bootstrap');
        loader.configFile = function(){
          return config.local;
        };
        return loader.hasConfig = function(){
          return true;
        };
      });
    });
  });
}).call(this);
