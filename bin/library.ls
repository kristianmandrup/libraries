#!/usr/bin/env node

manager = require '../index'
program = require 'commander'

program
  .version('0.0.1')
  .option '-f, --foo', 'enable some foo'
  .option '-b, --bar', 'enable some bar'
  .option '-B, --baz', 'enable some baz'

program
  .command 'help'
  .description 'display verbose help'
  .action ->
    # output help here

program
 .command 'setup'
 .description 'run setup commands'
 .action ->
   console.log 'setup'

# `library add bootstrap`
# `library add lib:bootstrap` (no component check)
# `library add cmp:bootstrap` - downloads bootstrap component config from registry if not present
# `library add bootstrap index.js` - will set the entry to `"bootstrap": "index.js"`

program
 .command 'add <lib>'
 .description 'add the given library'
 .action (lib) ->
   console.log 'add library "%s"', lib

#`library rm cmp:bootstrap` - removes bootstrap component config from registry
#`library rm bootstrap` - will remove entry from `selected` file.

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

program
 .command 'install'
 .description 'update the component registry'
 .action ->
   console.log 'install or update registry'


program.parse process.argv
#
# `library build`
#
# Will run `library update registry` and then run `libraries.importSelected()` which will generate the `imports.js` file
#  from the `selected` file.

#program
# .command 'build'
# .description 'build Brocfile imports'
# .action ->
#   console.log 'building Brocfile imports...'
