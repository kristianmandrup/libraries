// Generated by LiveScript 1.2.0
(function(){
  var cli, manager;
  cli = require('cli');
  manager = require('../index');
  cli.parse(null, ['add', 'remove', 'update', 'install', 'uninstall', 'list']);
  cli.main(function(args, options){
    console.log('args', args);
    return console.log('options', options);
  });
  console.log('Command is: ' + cli.command);
  program.command('help').description('display verbose help').action(function(){});
  program.command('setup').description('run remote setup commands').action(function(){
    return console.log('setup');
  });
  program.command('exec <cmd>').description('run the given remote command').action(function(cmd){
    return console.log('exec "%s"', cmd);
  });
  program.command('*').description('deploy the given env').action(function(env){
    return console.log('deploying "%s"', env);
  });
  program.parse(process.argv);
  program.option('-p, --pepper', 'add pepper');
  program.option('-C, --no-cheese', 'remove cheese');
  program.cheese;
  program.option('-C, --chdir <path>', 'change the working directory');
  program.option('-c, --cheese [type]', 'add cheese [marble]');
  program.prompt('Username: ', function(name){
    return console.log('hi %s', name);
  });
  program.prompt('Description:', function(desc){
    return console.log('description was "%s"', desc.trim());
  });
}).call(this);