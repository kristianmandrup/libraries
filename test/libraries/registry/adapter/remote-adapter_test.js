// Generated by LiveScript 1.2.0
(function(){
  var expect, log, Adapter, UriAdapter;
  expect = require('chai').expect;
  log = console.log;
  Adapter = require('../../../../../lib/registry/adapter/remote-adapter');
  UriAdapter = require('../../../../../lib/registry/adapter/remote/uri-adapter');
  describe('RemoteRegistryAdapter', function(){
    describe('create', function(){
      context('invalid', function(){
        return specify('num throws', function(){
          return expect(function(){
            return new Adapter(7);
          }).to['throw'];
        });
      });
      return context('valid', function(){
        specify('no args ok', function(){
          return expect(function(){
            return new Adapter;
          }).to.not['throw'];
        });
        return specify('empty object is ok', function(){
          return expect(function(){
            return new Adapter({});
          }).to.not['throw'];
        });
      });
    });
    return describe('valid instance', function(){
      var adapter;
      beforeEach(function(){
        return adapter = new Adapter;
      });
      describe('bad-adapter', function(){
        return specify('throws', function(){
          return expect(function(){
            return adapter.badAdapter().to['throw'];
          });
        });
      });
      describe('adapter', function(){
        return specify('creates adapter', function(){
          return expect(adapter.adapter()).to.be.an.instanceOf(UriAdapter);
        });
      });
      describe('selected-adapter', function(){
        return specify('finds adapter', function(){
          return expect(adapter.selectedAdapter()).to.eql(UriAdapter);
        });
      });
      return xdescribe('load', function(){
        return specify('loads registry', function(){
          return expect(adapter.load()).to.eql({});
        });
      });
    });
  });
}).call(this);
