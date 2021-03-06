``#!/usr/bin/env node``

libraries = require '../lib/libraries'
program   = require 'commander'

program
  .version('0.0.1')
#  .option '-f, --foo', 'enable some foo'
#  .option '-b, --bar', 'enable some bar'
#  .option '-B, --baz', 'enable some baz'

program
 .command 'setup <dir>'
 .description 'setup libraries'
 .action (dir) ->
   libraries.setup dir

# `library add bootstrap`
# `library add lib:bootstrap` (no component check)
# `library add cmp:bootstrap` - downloads bootstrap component config from registry if not present
# `library add bootstrap index.js` - will set the entry to `"bootstrap": "index.js"`
program
 .command 'add <libs>'
 .description 'add the given libraries'
 .action (libs) ->
   console.log 'add libraries "%s"', libs

#`library rm cmp:bootstrap` - removes bootstrap component config from registry
#`library rm bootstrap` - will remove entry from `selected` file.
program
 .command 'rm <libs>'
 .description 'remove the given libraries'
 .action (libs) ->
   console.log 'remove libraries "%s"', libs

program
 .command 'select <lib>'
 .description 'select the given library'
 .action (lib) ->
   console.log 'select library "%s"', lib
   libraries.select.add lib .save!
   libraries.install!

program
 .command 'unselect <lib>'
 .description 'unselect the given library'
 .action (lib) ->
   console.log 'unselect library "%s"', lib
   libraries.select.remove lib .save!
   libraries.install!

#`library install`
#
# Goes through `selected` file and checks each entry if it's a
# component by making a lookup in the registry `index.json` file (see below).
#
# If it's a component, it checks if it has a component config file in `components/ folder.
# If not, it downloads/copies the component config from the registry.

program
 .command 'install'
 .description 'install selected component configs from global registry'
 .action ->
   libraries.install!

program
 .command 'uninstall <component>'
 .description 'remove from component registry'
 .action (component) ->
   libraries.uninstall component

#
# `library build`
#
# Will run `library update registry` and then run `libraries.importSelected()` which will generate the `imports.js` file
#  from the `selected` file.

program
.command 'build <env>'
.description 'build Brocfile imports'
.action (env)->
   console.log 'building Brocfile imports for ' + env
   libraries.build env: env

#
# `library transfer <env>`
#
# Will transfer library config files from a lower environment to the one specified, i.e dev to test or test to prod

program
.command 'transfer <env>'
.description 'transfer environment'
.action (env)->
   console.log 'transfer to environment ' + env
   libraries.transfer env


program.parse process.argv

