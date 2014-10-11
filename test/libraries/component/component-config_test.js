// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 10/10/14
 * Time: 21:08
 */
(function(){
  var expect, Config, log;
  expect = require('chai').expect;
  Config = require('../../../lib/component/component-config');
  log = console.log;
  describe('ComponentConfig', function(){
    var config, name;
    before(function(){
      return name = 'bootstrap';
    });
    describe('create', function(){
      context('invalid', function(){
        specify('no args throws', function(){
          return expect(function(){
            return new Config;
          }).to['throw'];
        });
        specify('bad nam throws', function(){
          return expect(function(){
            return new Config(7);
          }).to['throw'];
        });
        specify('a name is ok', function(){
          return expect(function(){
            return new Config('x');
          }).to.not['throw'];
        });
        return specify('obj throws', function(){
          return expect(function(){
            return new Config({
              libs: 'x'
            }, 'blip');
          }).to['throw'];
        });
      });
      return context('valid', function(){
        return specify('allow empty obj', function(){
          return expect(function(){
            return new Config(name, name);
          }).to.not['throw'];
        });
      });
    });
    return describe('valid config', function(){
      beforeEach(function(){
        return config = new Config(name, './xlibs/components');
      });
      describe('config', function(){
        return specify('has name set', function(){
          return expect(config.name).to.equal(name);
        });
      });
      describe('valid-config', function(){
        specify('any object is valid', function(){
          return expect(config.validConfig({})).to.eql({});
        });
        return specify('any non-object is invalid', function(){
          return expect(function(){
            return config.validConfig('x');
          }).to['throw'];
        });
      });
      describe('component-file', function(){
        specify('is combined into a local repo file path', function(){
          return expect(config.componentFile()).to.eql('./xlibs/components/bootstrap.json');
        });
        return specify('blip is non-existing file path', function(){
          return expect(config.componentFile('blip')).to.eql('./xlibs/components/blip.json');
        });
      });
      describe('has-local', function(){
        return specify('bootstrap is in local repo', function(){
          return expect(config.hasLocal()).to.be['true'];
        });
      });
      describe('has-local(name)', function(){
        specify('bootstrap is in local repo', function(){
          return expect(config.hasLocal('bootstrap')).to.be['true'];
        });
        return specify('blip is not in local repo', function(){
          return expect(config.hasLocal('blip')).to.be['false'];
        });
      });
      describe('registry-file', function(){
        return specify('is combined into a registry file path', function(){
          return expect(config.registryFile()).to.eql('./xlibs/registry/bootstrap.json');
        });
      });
      describe('load', function(){
        context('registry config', function(){
          return specify('loads config from registry', function(){
            return expect(function(){
              return config.load('./xlibs/registry/bootstrap.json');
            }).to['throw'];
          });
        });
        return context('local config', function(){
          return specify('loads config from local repo', function(){
            return expect(config.load('./xlibs/components/bootstrap.json').dir).to.eql('dist');
          });
        });
      });
      return describe('loadIt', function(){
        return context('from local config', function(){
          return specify('loads config from registry', function(){
            return expect(config.loadIt().dir).to.eql('dist');
          });
        });
      });
    });
  });
}).call(this);