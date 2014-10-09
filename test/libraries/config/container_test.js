// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 06/10/14
 * Time: 14:38
 */
(function(){
  var expect, Container, log;
  expect = require('chai').expect;
  Container = require('../../../lib/config/container');
  log = console.log;
  describe('Configurator', function(){
    var container, conf;
    conf = {};
    conf.bower = {
      libs: {
        datepicker: "blip",
        'ember-validations': "dist/ember-validations"
      },
      components: ['bootstrap']
    };
    describe('create', function(){
      context('invalid', function(){
        specify('no args throws', function(){
          return expect(function(){
            return new Container;
          }).to['throw'];
        });
        specify('bad nam throws', function(){
          return expect(function(){
            return new Container(7);
          }).to['throw'];
        });
        return specify('non-existing file', function(){
          return expect(function(){
            return new Container('x');
          }).to.not['throw'];
        });
      });
      return context('valid', function(){
        specify('obj is ok', function(){
          return expect(function(){
            return new Container({
              libs: 'x'
            });
          }).to.not['throw'];
        });
        return specify('allow empty obj', function(){
          return expect(function(){
            return new Container({});
          }).to.not['throw'];
        });
      });
    });
    return describe('valid container', function(){
      beforeEach(function(){
        return container = new Container(conf.bower);
      });
      describe('components', function(){
        specify('not empty', function(){
          return expect(container.components()).to.not.be.empty;
        });
        return specify('includes boostrap', function(){
          return expect(container.components()).to.include("bootstrap");
        });
      });
      describe('libs', function(){
        specify('not empty', function(){
          return expect(container.libs()).to.not.be.empty;
        });
        return specify('has ember-validations', function(){
          return expect(container.libs()['ember-validations']).to.eql("dist/ember-validations");
        });
      });
      describe('libs-list', function(){
        return specify('not empty', function(){
          return expect(container.libsList()).to.not.be.empty;
        });
      });
      describe('is-component(name)', function(){
        specify('bootstrap is a component', function(){
          return expect(container.isComponent('bootstrap')).to.be['true'];
        });
        return specify('ember-validations is NOT a component', function(){
          return expect(container.isComponent('ember-validations')).to.be['false'];
        });
      });
      describe('is-lib(name)', function(){
        specify('bootstrap is NOT a component', function(){
          return expect(container.isLib('bootstrap')).to.be['false'];
        });
        return specify('ember-validations is NOT a component', function(){
          return expect(container.isLib('ember-validations')).to.be['true'];
        });
      });
      return describe('has(name)', function(){
        specify('bootstrap is there', function(){
          return expect(container.has('bootstrap')).to.be['true'];
        });
        return specify('ember-validations is there', function(){
          return expect(container.has('ember-validations')).to.be['true'];
        });
      });
    });
  });
}).call(this);