# Libraries

Libraries loader for Broccoli to make it easier and more efficient. 
We should avoid re-packaging every javascript library as a simple Ember CLI addon wrapper!! 

## Status

The infrastructure should now be (mostly) ready for action! Just needs some debugging and testing :)

## Why?

This project was created in response to ember-cli [#2177](https://github.com/stefanpenner/ember-cli/issues/2177).
It aims to make it easier and more flexible to configure libraries to be imported by Broccoli.

### Select libraries

`selected` is a simple text file, where each line is a library you wish to include :) 

```  
bootstrap
datepicker
...
```

or use the *library CLI* to add/remove selected libs: 

Add `library add foundation`

Remove `library rm bootstrap`

### Configuration

Libraries can be grouped by category (`bower`, `vendor`, `libs` etc.). 
You can configure a simple directory alias mechanism if you like in the config section `config`.

`config.json` contains configurations for all the simple (or custom) libraries

```javascript  
// config.json
{
  config: {
    'vendor': 'vendor/libs'
  },
  containers: {
    bower: {
      "components": [
        "bootstrap", 
        ...
      ],
      "libs: {    
        "datepicker": {"date": "dist/datepicker.js"}, 
        "calendar": "calendar.js",
        ...
      }    
    },
    vendor: {
      "components": [
        "bootstrap", 
        ...],
      "libs: {
        ...
      }
    }
  }
}
```

The `libs` entry is for simple libraries that are a single javascript file. 
Anything library with more than one file is a "component" and should have its own component configuration.

Component configuration:

```javascript
// bootstrap.json
{
    "dir": "dist",
    "scripts": {
        "dir": "js",
        "files": ["bootstrap.js"]
        "main":  {"bootstrap/core": "bootstrap.js"} // can be used to remap
    },
    "styles": {
        "dir": "css",
        "files": ["x.css"]
    },
    "fonts": {
        "dir": "fonts",
        "files": ["xyz.eof", "xyz.svg"]
    }
}
```

The `dir` entries are optional (but useful). The component structure will make it easy to do all kinds of 
interesting things in the future... (see Notes + Design documents for some ideas floating around in mind space...) 

### Registry

The global registry will contain an `index.js` file and a list of library config files.
Currently it is a `json` file (for extensibility). It could perhaps be a simple line-divided text file 
like the `selected` file if no other info is needed... 

```javascript
// index.json
{
  registry: [
    'bootstrap'
  ]
  ...
}
```

Registry files: 

```
index.json
bootstrap.json
...
```

On `library install`, the libraries you have selected which don't have a local library config in your local repo will
 be downloaded from the global registry.
 
Then you just have can run `library build` to build the `imports.js` file which `libraries` will use to 
apply on your `app` to do the magic imports! *Awesome 8>)* 

```js
function() {
  module.exports = function(app) {
    app.import('dist/js/bootstrap.js');
    app.import('dist/css/bootstrap.css');    
  }
}();
```

When you build, it will build an`imports-dev.js` if your environment is development and so on... This way you can
better manage which libraries have been tested to go into production without overwriting them 
when in dev or test mode. Super bonus!

### Petal integration for ES6 goodness

We also aim to integrate it nicely with petal and broccoli petal, in order that we can easily export (almost) any
 javascript library as an ES6 module for Ember CLI consumption :)

Petal test example:

```js
var source = fs.readFileSync('bower_components/moment/moment.js');
var m = new Petal('bower_components/moment/moment.js', source);

// moment.js exposed as 'moment' module as default
assert.deepEqual(m.exports, {
  'moment': ['default']
});
```

Petal will read the source file and convert it to en ES6 module to be saved on top of original (in this example).
  
`new Petal(destination, source)`
  
The ember-cli petal integration will likely support something an API like this:
   
`app.import('bower_components/famous/core', { remap: 'famous/core'' }`;`
   
which would somehow output all of this (/8>?
 
`https://github.com/abuiles/famous-remap/tree/master/famous-remapped`
 
According to comments in [#2177](https://github.com/stefanpenner/ember-cli/issues/2177)

### Ember config

The [ember-config](https://github.com/kristianmandrup/ember-config) generator will soon be refactored 
to instead export library/component config files instead of directly injecting `app.import` statements into the 
`Brocfile.js`. This will let you simply select the libraries you like via the generator and then install, build and import
 all the *import goodness* directly into the `Brocfile.js` >>> pure MAGIC!!

## Usage example

Here simulating the app object and doing `console.log` of the 
commands that the app object would normally execute on `app.import`

### Brocfile example

```javascript
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

require('libraries').applyOn(app);

module.exports = app.toTree();
```

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

The library API is very customizable. See the code for yourself! 

The `build` calls can each take a callback which allows you to fine-tune the output of 
any build, so as to not be hardcoded to be used for the Broccoli build process ;)
  
### License

MIT
