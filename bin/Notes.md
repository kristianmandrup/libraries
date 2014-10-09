#!/usr/bin/env node

# http://www.smashingmagazine.com/2014/02/12/build-cli-tool-nodejs-phantomjs/
# https://github.com/chevex/yargs

# cli     = require 'cli'
# options = cli.parse!

manager = require '../index'

program
 .command 'help'
 .description 'display verbose help'
 .action ->

program
 .command 'setup'
 .description 'run setup commands'
 .action ->
   console.log 'setup'

#`library add bootstrap`

# http://visionmedia.github.io/commander.js/#Command.prototype.command

#`library add lib:bootstrap` (no component check)
#
# If component, it will download component config.
#
#`library add cmp:bootstrap` - downloads bootstrap component config from registry if not present
#`library rm cmp:bootstrap` - removes bootstrap component config from registry
#
#`library add bootstrap index.js` - will set the entry to `"bootstrap": "index.js"`
#
#`library rm bootstrap` - will remove entry from `selected` file.

program
 .command 'add <lib>'
 .description 'add the given library'
 .action (lib) ->
   console.log 'add library "%s"', lib


program
 .command 'rm <lib>'
 .description 'rm the given library'
 .action (lib) ->
   console.log 'remove library "%s"', lib



#`library update registry`
#
# Goes through `selected` file and checks each entry if it's a component by making a lookup in the registry `index.json` file (see below).
#
# If it's a component, it check if it has a component config file in `components/ folder.
# If not, it downloads the component config from the registry.


#
# `library build`
#
# Will run `library update registry` and then run `libraries.importSelected()` which will generate the `imports.js` file
#  from the `selected` file.
#
#
#`library clean registry` - cleans registry from any components not currently selected in `selected` file.
#`library clean config` - cleans `config.json` and component registry based on `selected` file.
#
#`library install` - will run through entrie in `selected` file and then use `config.json` to validate if files exist.


#cli.main (args, options) ->
#  console.log 'args', args
#  console.log 'options', options
#
#console.log 'Command is: ' + cli.command


program
 .command('*')
 .description('deploy the given env')
 .action( (env) ->
   console.log('deploying "%s"', env)
 )

program.parse process.argv


# simple boolean defaulting to false
program.option '-p, --pepper', 'add pepper'

# --pepper
# program.pepper
# => Boolean

# simple boolean defaulting to false
program.option '-C, --no-cheese', 'remove cheese'

program.cheese
# => true

# --no-cheese
# program.cheese
# => true

# required argument
program.option '-C, --chdir <path>', 'change the working directory'

# --chdir /tmp
# program.chdir
# => "/tmp"

# optional argument
program.option '-c, --cheese [type]', 'add cheese [marble]'


program.prompt('Username: ', (name) ->
  console.log('hi %s', name);
)

program.prompt('Description:', (desc) ->
  console.log('description was "%s"', desc.trim())
)