// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
(function(){
  var expect, Configurator, log;
  expect = require('chai').expect;
  Configurator = require('../../../lib/config/configurator');
  log = console.log;
  describe('Configurator', function(){
    var configurator, conf;
    conf = {};
    conf.bootstrap = {
      dir: 'dist',
      scripts: {
        files: ['js/bootstrap.js']
      }
    };
    describe('create', function(){
      context('invalid', function(){
        specify('no args throws', function(){
          return expect(function(){
            return new Configurator;
          }).to['throw'];
        });
        specify('bad nam throws', function(){
          return expect(function(){
            return new Configurator(7);
          }).to['throw'];
        });
        return specify('non-existing file', function(){
          return expect(function(){
            return new Configurator('x');
          }).to.not['throw'];
        });
      });
      return context('valid', function(){
        return expect(function(){
          return new Configurator('./xlibs/config.json');
        }).to.not['throw'];
      });
    });
    return describe('valid component', function(){
      beforeEach(function(){
        return configurator = new Configurator;
      });
      describe('config', function(){
        return specify('loaded', function(){
          return expect(configurator.config.vendor).to.eql("vendor/prod");
        });
      });
      describe('containers', function(){
        return specify('is not empty', function(){
          return expect(configurator.containers).to.not.be.empty;
        });
      });
      return describe('container(name)', function(){
        specify('bower is not empty', function(){
          return expect(configurator.container('bower')).to.not.be['void'];
        });
        return specify('vendor has no libs', function(){
          return expect(configurator.container('vendor').libs()).to.eql({});
        });
      });
    });
  });
}).call(this);
