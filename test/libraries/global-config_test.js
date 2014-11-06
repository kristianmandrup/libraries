// Generated by LiveScript 1.2.0
(function(){
  var expect, log, GlobalConfig;
  expect = require('chai').expect;
  log = console.log;
  GlobalConfig = require('../../lib/global-config');
  describe('GlobalConfig', function(){
    describe('create(options)', function(){
      return specify('no args is valid', function(){
        return expect(function(){
          return new GlobalConfig.to.not['throw'];
        });
      });
    });
    return describe('instance', function(){
      var gconf;
      beforeEach(function(){
        return gconf = new GlobalConfig;
      });
      describe('librariesrc', function(){
        return specify('is .librariesrc', function(){
          return expect(gconf.librariesrc).to.eql('./.librariesrc');
        });
      });
      describe('default ...', function(){
        return specify('gets location', function(){
          return expect(gconf['default']().components().dir()).to.eql('./xlibs/components');
        });
      });
      describe('default-location-of', function(){
        specify('gets default components dir', function(){
          return expect(gconf.defaultLocationOf('components.dir')).to.eql('./xlibs/components');
        });
        return specify('gets default registry dir', function(){
          return expect(gconf.defaultLocationOf('registry.dir')).to.eql('./xlibs/registry');
        });
      });
      describe('location-of', function(){
        var config;
        beforeEach(function(){
          return config = {
            builds: {
              dir: 'xlibs/build'
            }
          };
        });
        specify('gets builds dir location', function(){
          return expect(gconf.locationOf('builds.dir', config)).to.eql('xlibs/build');
        });
        return specify('can not get registry dir location', function(){
          return expect(gconf.locationOf('registry.dir', config)).to.eql(void 8);
        });
      });
      describe('location', function(){
        return specify('can not get registry dir location', function(){
          return expect(gconf.location('registry.dir')).to.eql('./xlibs/registry');
        });
      });
      describe('select.file', function(){
        return specify('gets location', function(){
          return expect(gconf.location('select.file')).to.eql('./xlibs/select');
        });
      });
      describe('builds.dir', function(){
        return specify('gets location', function(){
          return expect(gconf.location('builds.dir')).to.eql('./xlibs/builds');
        });
      });
      describe('components.dir', function(){
        return specify('gets location', function(){
          return expect(gconf.location('components.dir')).to.eql('./xlibs/components');
        });
      });
      describe('components.file', function(){
        return specify('gets location', function(){
          return expect(gconf.location('components.file')).to.eql('./xlibs/components/index.json');
        });
      });
      describe('config.file', function(){
        return specify('gets location', function(){
          return expect(gconf.location('config.file')).to.eql('./xlibs/config.json');
        });
      });
      describe('registry.dir', function(){
        return specify('gets location', function(){
          return expect(gconf.location('registry.dir')).to.eql('./xlibs/registry');
        });
      });
      describe('default registry.dir', function(){
        return specify('gets location', function(){
          return expect(gconf['default']().registry().dir()).to.eql('./xlibs/registry');
        });
      });
      describe('dir-for', function(){
        return specify('bower', function(){
          return expect(gconf.dirFor('bower')).to.eql('bower_components');
        });
      });
      describe('find', function(){
        return specify('finds obj via path', function(){
          return expect(gconf.find({
            preferences: 'x'
          }, 'preferences')).to.eql('x');
        });
      });
      return describe('preferences', function(){
        return specify('loads all', function(){
          log('prefs', gconf.preferences());
          return expect(gconf.preferences().styles).to.eql(['scss', 'sass', 'less', 'css']);
        });
      });
    });
  });
}).call(this);
