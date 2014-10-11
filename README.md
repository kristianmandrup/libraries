# Libraries

Libraries loader for Broccoli to make it easier and more efficient. 
We should avoid re-packaging every javascript library as a simple Ember CLI addon wrapper!! 

## Status

The infrastructure should now be (mostly) ready for action! Just needs some debugging and testing :)

## Why?

This small project was created in response to ember-cli [#2177](https://github.com/stefanpenner/ember-cli/issues/2177).
It aims to make it easier and more flexible to configure libraries to be imported by Broccoli. 

Configuration is now externalised. Libraries can be grouped by category. We can configure a simple directory alias mechanism etc.
 We can even include automatic support for remapping.

Using a JSON format we can allow (code) generators to automatically process, append or remove libraries as needed 
using the JSON structure ;)

One such util which will soon take advantage of this is [ember-config](https://github.com/kristianmandrup/ember-config) generator.

## Usage example

Here simulating the app object and doing `console.log` of the 
commands that the app object would normally execute on `app.import`

```coffeescript
app =
  import: (location) ->
    console.log 'app.import("' + location + '");'
  bowerDirectory: 'bower_components'

require('libraries').applyOn(app);

# or passing custom options 

libraries = new Libraries file: './xlibs/imports-libraries.json', config: {vendor: 'vendor/dev'}
libraries.applyOn(app) 
```

### Brocfile example

```javascript
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

// Use `app.import` to add additional libraries to the generated

require('libraries').applyOn(app);

module.exports = app.toTree();
```

### Use existing component infrastructure

[what is the Bower main property](http://stackoverflow.com/questions/20391742/what-is-the-main-property-when-doing-bower-init)

Would be awesome to take advantage of this :)

```javascript
{
  "name": "bootstrap",
  "version": "3.0.3",
  "main": [
    // scripts
    "./dist/css/bootstrap.css",
    
    // styles
    "./dist/js/bootstrap.js",

    // fonts
    "./dist/fonts/glyphicons-halflings-regular.eot",
    "./dist/fonts/glyphicons-halflings-regular.svg",
    "./dist/fonts/glyphicons-halflings-regular.ttf",
    "./dist/fonts/glyphicons-halflings-regular.woff"
  ],
  "dependencies": {
    "jquery": ">= 1.9.0"
  }
}    
```

ComponentJs has similar features that can be used.

### CLI support

*Deprecated* See `bin/library` for more recent CLI API

- Add CLI interface to add/remove via CLI commands

Add a library to selection

`library add bootstrap`

Remove a library from selection

`library rm bootstrap`

Install all library configs selected that are not part of local library configuration repo
Missing configurations are fetched from remote repo/repository and installed locally!

`library install`

Build javascript imports from selected libraries, using local library configuration.
Save as javascript file, ready to be used via `require('libraries').applyOn(app);` in `Brocfile.js`
 
`library build` 
 
Please help out to make this an awesome experience and greatly enhance productivity for all of us... ;)

*Enjoy :)*

### Customization



### License

MIT
