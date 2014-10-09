#!/usr/bin/env node

(function(){
  var libraries, program;
  libraries = require('../lib/libraries');
  program = require('commander');
  program.version('0.0.1').option('-f, --foo', 'enable some foo').option('-b, --bar', 'enable some bar').option('-B, --baz', 'enable some baz');
  program.command('help').description('display verbose help').action(function(){});
  program.command('setup').description('run setup commands').action(function(){
    return console.log('setup');
  });
  program.command('add <lib>').description('add the given library').action(function(lib){
    console.log('add library "%s"', lib);
    return libraries.select.add(lib).save();
  });
  program.command('rm <lib>').description('rm the given library').action(function(lib){
    return console.log('remove library "%s"', lib);
  });
  program.command('install').description('update the component registry').action(function(){
    return console.log('install or update registry');
  });
  program.command('build').description('build Brocfile imports').action(function(){
    console.log('building Brocfile imports...');
    return libraries.build();
  });
  program.parse(process.argv);
}).call(this);
