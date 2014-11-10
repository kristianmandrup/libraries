// Generated by LiveScript 1.2.0
(function(){
  var expect, Adapter, log;
  expect = require('chai').expect;
  Adapter = require('../../../../lib/registry/adapter/basic-adapter');
  log = console.log;
  describe('Adapter', function(){
    return describe('create', function(){
      context('invalid', function(){
        return specify('bad nam throws', function(){
          return expect(function(){
            return new Adapter(7);
          }).to['throw'];
        });
      });
      context('valid', function(){
        specify('no args is ok', function(){
          return expect(function(){
            return new Adapter({
              type: 'local'
            });
          }).to.not['throw'];
        });
        return specify('type: is ok', function(){
          return expect(function(){
            return new Adapter({
              type: 'local'
            });
          }).to.not['throw'];
        });
      });
      return context('valid instance', function(){
        var adapter;
        beforeEach(function(){
          return adapter = new Adapter;
        });
        describe('type', function(){
          return specify('is bower', function(){
            return expect(adapter.type).to.eql('bower');
          });
        });
        describe('installer-type', function(){
          return specify('is json', function(){
            return expect(adapter.installerType).to.eql('json');
          });
        });
        describe('adapter-type', function(){
          return specify('is pkg', function(){
            return expect(adapter.adapterType).to.eql('pkg');
          });
        });
        describe('selected-adapter', function(){
          return specify('throws', function(){
            return expect(function(){
              return adapter.selectedAdapter().to['throw'];
            });
          });
        });
        describe('adapter', function(){
          return specify('is LocalAdapter', function(){
            return expect(function(){
              return adapter.adapter().to['throw'];
            });
          });
        });
        describe('install', function(){
          return specify('installs it', function(){
            return expect(function(){
              return adapter.install().to['throw'];
            });
          });
        });
        return describe('load', function(){
          return specify('installs bootstrap', function(){
            return expect(function(){
              return adapter.load().to['throw'];
            });
          });
        });
      });
    });
  });
}).call(this);