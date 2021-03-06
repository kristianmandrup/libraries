// Generated by LiveScript 1.2.0
(function(){
  var FileIO, RegistryClient, registry, search, syncRequest, retrieve, fs, util, jsonlint, Q, isBlank, escapeRegExp, GithubRepoTranslator, BaseBowerAdapter, logx, RemoteBowerAdapter, toString$ = {}.toString;
  FileIO = require('../../../../util/file-io');
  RegistryClient = require('bower-registry-client');
  registry = new RegistryClient({
    strictSsl: false,
    timeout: 12000
  });
  search = registry.lookup;
  syncRequest = require('sync-request');
  retrieve = require('../../../../util/remote').retrieve;
  fs = require('fs-extra');
  util = require('util');
  jsonlint = require('jsonlint');
  Q = require('q');
  isBlank = function(str){
    return !str || /^\s*$/.test(str);
  };
  escapeRegExp = function(str){
    return str.replace(/([.*+?^${}()|\[\]\/\\])/g, "\\$1");
  };
  GithubRepoTranslator = require('./github-repo-translator');
  BaseBowerAdapter = require('./base-bower');
  logx = function(msg){
    return console.log(util.inspect(msg));
  };
  module.exports = RemoteBowerAdapter = (function(superclass){
    var prototype = extend$((import$(RemoteBowerAdapter, superclass).displayName = 'RemoteBowerAdapter', RemoteBowerAdapter), superclass).prototype, constructor = RemoteBowerAdapter;
    function RemoteBowerAdapter(name, options){
      this.name = name;
      this.options = options != null
        ? options
        : {};
      RemoteBowerAdapter.superclass.apply(this, arguments);
    }
    prototype.retrieve = function(){
      var this$ = this;
      return this.repoUri().then(function(uri){
        return this$.retrieveBody(uri);
      });
    };
    prototype.retrieveBody = function(uri){
      var deferred, this$ = this;
      deferred = Q.defer();
      retrieve(uri, deferred.makeNodeResolver());
      return deferred.promise.then(function(body){
        return body;
      });
    };
    prototype.retrieveSync = function(){
      var this$ = this;
      return this.repoUri().then(function(uri){
        return this$.retrieved || (this$.retrieved = syncRequest('GET', uri).getBody());
      });
    };
    prototype.repoTranslator = function(repo){
      return new GithubRepoTranslator(repo);
    };
    prototype.repoUri = function(){
      var this$ = this;
      return this.repo().then(function(repo){
        this$._repo = repo;
        return this$.repoTranslator(repo).translate();
      });
    };
    prototype.repos = [];
    prototype.repo = function(){
      return this.findRepos(function(repos){
        if (repos.length === 0) {
          return this.repos[0];
        } else {
          return repos[0];
        }
      });
    };
    prototype.filtered = function(){
      var this$ = this;
      return this._filtered || (this._filtered = this.foundRepos.filter(function(repo){
        var name;
        name = escapeRegExp(this$.name);
        return repo.match(new RegExp(name + ".git$"));
      }));
    };
    prototype.findRepos = function(cb){
      var this$ = this;
      return this.find().promise.then(function(foundRepos){
        this$.foundRepos = this$.map(foundRepos);
        return cb(this$.filtered());
      });
    };
    prototype.map = function(repos){
      var this$ = this;
      switch (toString$.call(repos).slice(8, -1)) {
      case 'Object':
        return [repos.url];
      case 'Array':
        return repos.map(function(repo){
          return this$.map(repo);
        });
      }
    };
    prototype.find = function(){
      var deferred;
      deferred = Q.defer();
      registry.lookup(this.name, deferred.makeNodeResolver());
      return deferred;
    };
    return RemoteBowerAdapter;
  }(BaseBowerAdapter));
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
