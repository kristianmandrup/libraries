// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
(function(){
  var expect, Configurator, log;
  expect = require('chai').expect;
  Configurator = require('../../lib/config/configurator');
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
      describe('part', function(){
        specify('bower is not empty', function(){
          return expect(configurator.part('bower')).to.not.be.empty;
        });
        return specify('vendor is empty', function(){
          return expect(configurator.part('vendor')).to.eql({});
        });
      });
      describe('components', function(){
        specify('not empty', function(){
          return expect(configurator.part('bower').components).to.not.be.empty;
        });
        return specify('includes boostrap', function(){
          return expect(configurator.part('bower').components).to.include("boostrap");
        });
      });
      return describe('libs', function(){
        specify('not empty', function(){
          return expect(configurator.part('bower').libs).to.not.be.empty;
        });
        return specify('has ember-validations', function(){
          return expect(configurator.part('bower').libs['ember-validations']).to.eql("dist/ember-validations");
        });
      });
    });
  });
}).call(this);
