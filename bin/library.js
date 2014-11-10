#!/usr/bin/env node
(function(){
  var libraries, program;
  libraries = require('../lib/libraries');
  program = require('commander');
  program.version('0.0.1');
  program.command('setup <dir>').description('setup libraries').action(function(dir){
    return libraries.setup(dir);
  });
  program.command('add <libs>').description('add the given libraries').action(function(libs){
    return console.log('add libraries "%s"', libs);
  });
  program.command('rm <libs>').description('remove the given libraries').action(function(libs){
    return console.log('remove libraries "%s"', libs);
  });
  program.command('select <lib>').description('select the given library').action(function(lib){
    console.log('select library "%s"', lib);
    libraries.select.add(lib).save();
    return libraries.install();
  });
  program.command('unselect <lib>').description('unselect the given library').action(function(lib){
    console.log('unselect library "%s"', lib);
    libraries.select.remove(lib).save();
    return libraries.install();
  });
  program.command('install').description('install selected component configs from global registry').action(function(){
    return libraries.install();
  });
  program.command('uninstall <component>').description('remove from component registry').action(function(component){
    return libraries.uninstall(component);
  });
  program.command('build <env>').description('build Brocfile imports').action(function(env){
    console.log('building Brocfile imports for ' + env);
    return libraries.build({
      env: env
    });
  });
  program.command('transfer <env>').description('transfer environment').action(function(env){
    console.log('transfer to environment ' + env);
    return libraries.transfer(env);
  });
  program.parse(process.argv);
}).call(this);
