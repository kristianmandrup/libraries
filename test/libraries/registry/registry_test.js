// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
(function(){
  var expect, Registry, log;
  expect = require('chai').expect;
  Registry = require('../../lib/registry/registry');
  log = console.log;
  describe('Registry', function(){
    var registry;
    describe('create', function(){
      context('invalid', function(){
        return specify('bad nam throws', function(){
          return expect(function(){
            return new Registry(7);
          }).to['throw'];
        });
      });
      return context('valid', function(){
        specify('no args ok', function(){
          return expect(function(){
            return new Registry;
          }).to.not['throw'];
        });
        return specify('string arg ok', function(){
          return expect(function(){
            return new Registry('./xlibs/config.json');
          }).to.not['throw'];
        });
      });
    });
    return describe('valid component', function(){
      beforeEach(function(){
        return registry = new Registry;
      });
      describe('registry-uri', function(){
        return specify('is path', function(){
          return expect(registry.registryUri).to.eql("./xlibs/registry");
        });
      });
      describe('target-path', function(){
        return specify('is path', function(){
          return expect(registry.localRegistryPath).to.eql("./xlibs/registry");
        });
      });
      describe('index-file', function(){
        return specify('is path', function(){
          return expect(registry.indexFile()).to.eql("./xlibs/registry/index.json");
        });
      });
      describe('index', function(){
        return specify('is json', function(){
          return expect(registry.index()).to.eql({
            blip: 'blap'
          });
        });
      });
      describe('config-file(name)', function(){
        return specify('is path', function(){
          return expect(registry.configFile('bootstrap')).to.eql("./xlibs/registry/bootstrap.json");
        });
      });
      describe('target-config(name)', function(){
        return specify('is path', function(){
          return expect(registry.targetConfig('bootstrap')).to.eql("./xlibs/registry/bootstrap.json");
        });
      });
      describe('install(name, path)', function(){
        before(function(){
          return registry.install('bootstrap');
        });
        return specify('is installed', function(){
          return expect(1);
        });
      });
      return describe('uninstall(name, path)', function(){
        before(function(){
          return registry.uninstall('bootstrap');
        });
        return specify('is uninstalled', function(){
          return expect(1);
        });
      });
    });
  });
}).call(this);
