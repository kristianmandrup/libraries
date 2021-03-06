// Generated by LiveScript 1.2.0
(function(){
  var expect, Installer, log, toString$ = {}.toString;
  expect = require('chai').expect;
  Installer = require('../../../../../lib/registry/config/installer/json-installer');
  log = console.log;
  describe('JsonInstaller', function(){
    var installer, config;
    config = {};
    describe('create', function(){
      context('invalid', function(){
        return specify('bad nam throws', function(){
          return expect(function(){
            return new Installer(7);
          }).to['throw'];
        });
      });
      return context('valid', function(){
        specify('name string is ok', function(){
          return expect(function(){
            return new Installer('x');
          }).to.not['throw'];
        });
        return specify('name, path string ok', function(){
          return expect(function(){
            return new Installer('x', 'y');
          }).to.not['throw'];
        });
      });
    });
    return describe('valid instance', function(){
      var io;
      before(function(){
        io = function(msg){
          return msg;
        };
        config.bootstrap = {
          files: ['dist/js/bootstrap.js']
        };
        return installer = new Installer('bs', config.bootstrap, {
          log: io
        });
      });
      describe('installing', function(){
        return specify('displays console install msg', function(){
          return expect(installer.installing()).to.match(/installing/);
        });
      });
      describe('uninstalling', function(){
        return specify('displays console uninstall msg', function(){
          return expect(installer.uninstalling()).to.match(/uninstalling/);
        });
      });
      describe('json', function(){
        return specify('returns json of local components file', function(){
          return expect(toString$.call(installer.json()).slice(8, -1)).to.eql('Object');
        });
      });
      describe('components', function(){
        return specify('returns components entry', function(){
          return expect(toString$.call(installer.components()).slice(8, -1)).to.eql('Object');
        });
      });
      describe('stringified', function(){
        return specify('returns json as string', function(){
          return expect(installer.stringified()).to.eql("{\"files\":[\"dist/js/bootstrap.js\"]}");
        });
      });
      describe('install', function(){
        beforeEach(function(){
          return installer.install(true);
        });
        return specify('installs json of component into components.json', function(){
          return expect(installer.components().bs).to.eql(config.bootstrap);
        });
      });
      return describe.only('install and uninstall', function(){
        beforeEach(function(){
          return installer.install(true);
        });
        return specify('uninstalls bootstrap entry from components.json', function(){
          expect(installer.components().bs).to.eql(config.bootstrap);
          installer.uninstall();
          return expect(installer.components().bs).to.eql(void 8);
        });
      });
    });
  });
}).call(this);
