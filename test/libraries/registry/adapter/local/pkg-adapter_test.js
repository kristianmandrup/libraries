// Generated by LiveScript 1.2.0
(function(){
  var expect, log, Adapter, Installer, Enricher;
  expect = require('chai').expect;
  log = console.log;
  Adapter = require('../../../../../lib/registry/adapter/local/pkg-adapter');
  Installer = require('../../../../../lib/registry/config/installer');
  Enricher = require('../../../../../lib/registry/config/enricher');
  describe('PkgAdapter', function(){
    var adapter;
    describe('create', function(){
      context('invalid', function(){
        specify('number throws', function(){
          return expect(function(){
            return new Adapter(7);
          }).to['throw'];
        });
        return specify('string throws', function(){
          return expect(function(){
            return new Adapter('./xlibs/config.json');
          }).throws;
        });
      });
      return context('valid', function(){
        specify('no args ok', function(){
          return expect(function(){
            return new Adapter;
          }).to['throw'];
        });
        return specify('empty obj ok', function(){
          return expect(function(){
            return new Adapter({});
          }).to.not['throw'];
        });
      });
    });
    return describe('valid instance', function(){
      var uri, path;
      before(function(){
        adapter = new Adapter({
          name: 'bootstrap'
        });
        return path = 'bower_components/libraries/registry/bower-libs.json';
      });
      describe('pkg-path', function(){
        return specify('is path', function(){
          return expect(adapter.pkgPath).to.eql('bower_components');
        });
      });
      describe('registry-libs-uri', function(){
        return specify('is path', function(){
          return expect(adapter.registryLibsUri()).to.eql(path);
        });
      });
      describe('installer', function(){
        return specify('is path', function(){
          return expect(adapter.installer()).to.be.an.instanceOf(Installer);
        });
      });
      describe('index-content', function(){
        return specify('is path', function(){
          return adapter.indexContent().then(function(body){
            return expect(body).to.match(/ember-i18n/);
          });
        });
      });
      describe('index', function(){
        return specify('is json', function(){
          return adapter.index().then(function(json){
            return expect(json["ember-i18n"].categories).to.include('i18n');
          });
        });
      });
      describe('list', function(){
        return specify('is json', function(){
          return adapter.list().then(function(list){
            return expect(list).to.include("ember-i18n");
          });
        });
      });
      describe('read-config', function(){
        return specify('is json', function(){
          return adapter.readConfig("ember-i18n").then(function(res){
            return expect(res.files).to.include('lib/i18n.js');
          });
        });
      });
      return describe('enrich-and-normalize', function(){
        return specify('enriches and normalizes', function(){
          return adapter.enrichAndNormalize("ember-i18n").then(function(res){
            return expect(res.scripts.files).to.include('i18n.js');
          });
        });
      });
    });
  });
}).call(this);