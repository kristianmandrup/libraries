// Generated by LiveScript 1.2.0
(function(){
  var expect, log, FileInstaller, JsonInstaller, Installer;
  expect = require('chai').expect;
  log = console.log;
  FileInstaller = require('../../../../lib/registry/config/installer/file-installer');
  JsonInstaller = require('../../../../lib/registry/config/installer/json-installer');
  Installer = require('../../../../lib/registry/config/installer');
  describe('Installer', function(){
    return describe('create(type, args)', function(){
      context('invalid', function(){
        specify('Object arg throws', function(){
          return expect(function(){
            return new Installer({
              x: 2
            }).to['throw'];
          });
        });
        return specify('no args fails', function(){
          return expect(function(){
            return new Installer.to['throw'];
          });
        });
      });
      context('valid', function(){
        return specify('string json ok', function(){
          return expect(function(){
            return new Installer('json').to.not['throw'];
          });
        });
      });
      context('default instance', function(){
        var installer;
        beforeEach(function(){
          return installer = new Installer('file', 'bootstrap', ' ');
        });
        describe('type', function(){
          return specify('default set to file', function(){
            return expect(installer.type).to.eql('file');
          });
        });
        describe('installer', function(){
          return specify('default is FileInstaller', function(){
            return expect(installer.installer()).to.be.an.instanceOf(FileInstaller);
          });
        });
        describe('selected-installer', function(){
          return specify('is FileInstaller', function(){
            return expect(installer.selectedInstaller()).to.eql(FileInstaller);
          });
        });
        return describe('install', function(){
          return specify('installs component', function(){
            return expect(true).to.be['false'];
          });
        });
      });
      return context('json instance', function(){
        var installer;
        beforeEach(function(){
          return installer = new Installer('json', 'bootstrap', {
            x: '2'
          });
        });
        describe('type', function(){
          return specify('default set to file', function(){
            return expect(installer.type).to.eql('json');
          });
        });
        describe('installer', function(){
          return specify('default is FileInstaller', function(){
            return expect(installer.installer()).to.be.an.instanceOf(JsonInstaller);
          });
        });
        return describe('install', function(){
          return specify('installs component', function(){
            return expect(true).to.be['false'];
          });
        });
      });
    });
  });
}).call(this);
