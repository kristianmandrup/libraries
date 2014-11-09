// Generated by LiveScript 1.2.0
(function(){
  var expect, LocalAdapter, Registry, log;
  expect = require('chai').expect;
  LocalAdapter = require('../../../lib/registry/adapter/local-adapter');
  Registry = require('../../../lib/registry/registry');
  log = console.log;
  describe('Registry', function(){
    return describe('create', function(){
      context('invalid', function(){
        return specify('bad nam throws', function(){
          return expect(function(){
            return new Registry(7);
          }).to['throw'];
        });
      });
      context('valid', function(){
        specify('no args is ok', function(){
          return expect(function(){
            return new Registry({
              type: 'local'
            });
          }).to.not['throw'];
        });
        return specify('type: is ok', function(){
          return expect(function(){
            return new Registry({
              type: 'local'
            });
          }).to.not['throw'];
        });
      });
      return context('valid instance', function(){
        var registry;
        beforeEach(function(){
          return registry = new Registry;
        });
        describe('selected-adapter', function(){
          return specify('is LocalAdapter class', function(){
            return expect(registry.selectedAdapter()).to.eql(LocalAdapter);
          });
        });
        describe('adapter', function(){
          return specify('is LocalAdapter', function(){
            return expect(registry.adapter()).to.be.an.instanceOf(LocalAdapter);
          });
        });
        return describe('install(name)', function(){
          return specify('installs bootstrap', function(){
            return expect(function(){
              return registry.install('bootstrap').to.not['throw'];
            });
          });
        });
      });
    });
  });
}).call(this);
