// Generated by LiveScript 1.2.0
/**
 * User: kristianmandrup
 * Date: 07/10/14
 * Time: 23:16
 */
(function(){
  var expect, Components, Component, ConfigLoader, log;
  expect = require('chai').expect;
  Components = require('../../../lib/component/components');
  Component = require('../../../lib/component/component');
  ConfigLoader = require('../../../lib/component/component-config');
  log = console.log;
  describe('Components', function(){
    var components, cmps;
    cmps = {};
    cmps.some = ['bootstrap', 'foundation'];
    describe('create', function(){
      context('invalid', function(){
        specify('no args throws', function(){
          return expect(function(){
            return new Components;
          }).to['throw'];
        });
        specify('number throws', function(){
          return expect(function(){
            return new Components(7);
          }).to['throw'];
        });
        specify('string throws', function(){
          return expect(function(){
            return new Components('x');
          }).to['throw'];
        });
        return specify('list ok', function(){
          return expect(function(){
            return new Components(['blip']);
          }).to['throw'];
        });
      });
      return context('valid', function(){
        return specify('empty list ok', function(){
          return expect(function(){
            return new Components([]);
          }).to.not['throw'];
        });
      });
    });
    return describe('valid components', function(){
      var components, cmp;
      beforeEach(function(){
        components = new Components(cmps.some);
        return cmp = 'bootstrap';
      });
      describe('component(name)', function(){
        return specify('must be a Component', function(){
          return expect(components.component(cmp, {})).to.be.an.instanceOf(Component);
        });
      });
      describe('index(name)', function(){
        specify('strapper not there', function(){
          return expect(components.index('strapper')).to.equal(-1);
        });
        return specify('bootstrap is there', function(){
          return expect(components.index(cmp)).to.equal(0);
        });
      });
      describe('add-one(name)', function(){
        var oldLength;
        before(function(){
          oldLength = components.list.length;
          return components.addOne(cmp);
        });
        specify('doesn not add duplicate', function(){
          return expect(components.list).to.include(cmp);
        });
        specify('length is unchanged', function(){
          return expect(components.list.length).to.eql(oldLength);
        });
        return describe('index(name)', function(){
          return specify('strapper is there', function(){
            return expect(components.index(cmp)).to.eql(0);
          });
        });
      });
      describe('has(name)', function(){
        return specify('strapper is there', function(){
          return expect(components.has(cmp)).to.be['true'];
        });
      });
      describe('component(name)', function(){
        return specify('is a Component', function(){
          return expect(components.component('bootstrap', {})).to.be.an.instanceOf(Component);
        });
      });
      describe('component-object(name)', function(){
        return specify('is an Object', function(){});
      });
      describe('remove-one(name)', function(){
        return specify('removes it', function(){
          return expect(components.removeOne(cmp).list).to.not.include(cmp);
        });
      });
      describe('listed-components', function(){
        return specify('build all configurations', function(){
          return expect(components.listedComponents().foundation.dir).to.eql('dist');
        });
      });
      describe('component-config(name)', function(){
        var config;
        before(function(){
          return config = components.componentConfig('bootstrap', './xlibs/components');
        });
        specify('is a ConfigLoader', function(){
          return expect(config).to.be.an.instanceOf(ConfigLoader);
        });
        specify('is configured with name', function(){
          return expect(config.name).to.eql('bootstrap');
        });
        return specify('is configured with path', function(){
          return expect(config.path).to.eql('./xlibs/components');
        });
      });
      describe('all', function(){
        var all;
        before(function(){
          return all = components.all();
        });
        specify('creates all components', function(){
          return expect(all.length).to.eql(1);
        });
        return specify('first is a foundation component', function(){
          return expect(all[0].name).to.eql('foundation');
        });
      });
      describe('build', function(){
        var build;
        before(function(){
          return build = components.build();
        });
        return specify('builds all components', function(){
          return expect(build).to.eql('');
        });
      });
      return describe('install', function(){});
    });
  });
}).call(this);
