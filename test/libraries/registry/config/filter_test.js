// Generated by LiveScript 1.2.0
(function(){
  var expect, log, Filter;
  expect = require('chai').expect;
  log = console.log;
  Filter = require('../../../../lib/registry/config/filter');
  describe('Filter', function(){
    var config;
    config = {};
    config.bs = {
      scripts: {
        files: ['js/bootstrap.min.js', 'js/bootstrap.js']
      },
      styles: {
        files: ['css/bootstrap.less', 'css/bootstrap.css']
      }
    };
    return context('instance', function(){
      var filter;
      beforeEach(function(){
        return filter = new Filter(config.bs);
      });
      describe.only('filter', function(){
        return specify('filters for all prefs', function(){
          return expect(filter.filter()).to.eql({
            scripts: {
              files: ['js/bootstrap.js']
            },
            styles: {
              files: ['css/bootstrap.less']
            }
          });
        });
      });
      describe('filter-on(name)', function(){
        specify('filters scripts using prefs', function(){
          return expect(filter.filterOn('scripts')).to.eql(['js/bootstrap.js']);
        });
        return specify('filters styles using prefs', function(){
          return expect(filter.filterOn('styles')).to.eql(['css/bootstrap.less']);
        });
      });
      describe('filter-one(files, file)', function(){
        specify('filters files using prefs', function(){
          return expect(filter.filterOne(['css/bootstrap.less', 'css/boot.css', 'css/bootstrap.css'], 'css/bootstrap.css', ['less', 'css'])).to.eql(['css/bootstrap.less', 'css/boot.css']);
        });
        return specify('filters away .min.js files', function(){
          return expect(filter.filterOne(['js/bootstrap.min.js', 'js/bootstrap.js'], 'js/bootstrap.js', ['js', 'min.js'])).to.eql(['js/bootstrap.js']);
        });
      });
      describe('filter-pref(files, pref)', function(){
        specify('filters using css ext prefs', function(){
          return expect(filter.filterPref(['css/bootstrap.less', 'css/bootstrap.css'], ['less', 'css'])).to.eql('css/bootstrap.less');
        });
        return specify('filters using js extension prefs', function(){
          return expect(filter.filterPref(['js/bootstrap.min.js', 'js/bootstrap.js'], ['js', 'min.js'])).to.eql('js/bootstrap.js');
        });
      });
      describe('same(files, file)', function(){
        specify('matches on same file extension', function(){
          return expect(filter.same(['css/bootstrap.less', 'css/boot.css', 'css/bootstrap.css'], 'css/bootstrap.css')).to.eql(['css/bootstrap.less', 'css/bootstrap.css']);
        });
        return specify('matches on same file full extension', function(){
          return expect(filter.same(['js/bootstrap.min.js', 'js/bootstrap.js'], 'js/bootstrap.js')).to.eql(['js/bootstrap.min.js', 'js/bootstrap.js']);
        });
      });
      describe('file-name(file)', function(){
        return specify('bootstrap.min.js is just bootstrap', function(){
          return expect(filter.fileName('bootstrap.min.js')).to.eql('bootstrap');
        });
      });
      describe('matches(file, pref)', function(){
        specify('matches on same file extension', function(){
          return expect(filter.matches('js/bootstrap.js', 'js')).to.be['true'];
        });
        specify('does not match on diff file extension', function(){
          return expect(filter.matches('js/bootstrap.js', 'min.js')).to.be['false'];
        });
        return specify('does not match on diff full file extension', function(){
          return expect(filter.matches('js/bootstrap.min.js', 'js')).to.be['false'];
        });
      });
      describe('config-for(name)', function(){
        return specify('gets scripts config', function(){
          return expect(filter.configFor('scripts')).to.eql({
            files: ['js/bootstrap.min.js', 'js/bootstrap.js']
          });
        });
      });
      describe('prefs-for(name)', function(){
        specify('gets scripts prefs', function(){
          return expect(filter.prefsFor('scripts')).to.eql(['js', 'min.js']);
        });
        return specify('gets styles prefs', function(){
          return expect(filter.prefsFor('styles')).to.include('scss');
        });
      });
      describe('filter-pref-keys', function(){
        return specify('does not match on diff file extension', function(){
          return expect(filter.filterPrefKeys()).to.include('scripts', 'styles');
        });
      });
      describe('filter-prefs', function(){
        return specify('does not match on diff file extension', function(){
          return expect(filter.filterPrefs().styles).to.include('scss', 'sass', 'less', 'css');
        });
      });
      return describe('filter-one', function(){
        var files, file;
        beforeEach(function(){
          file = 'bootstrap.less';
          return files = ['bootstrap.css', 'bootstrap.less', 'bootstrap.scss'];
        });
        return specify('does not match on diff file extension', function(){
          return expect(filter.filterOne(files, file)).to.eql([]);
        });
      });
    });
  });
}).call(this);
