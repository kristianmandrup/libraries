# Libraries

Libraries loader for Broccoli to make it easier and more efficient. 
We should avoid re-packaging every javascript library as a simple Ember CLI addon wrapper!! 

## Why?

This project was created in response to ember-cli [#2177](https://github.com/stefanpenner/ember-cli/issues/2177).
It aims to make it easier and more flexible to configure libraries to be imported by Broccoli.

## Status

Most of the infrastructure is now in place.

From [Registry.md](https://github.com/kristianmandrup/libraries/blob/master/lib/registry/Registry.md)

_Currently the registry configs are installed "as is", which only works if the full library configuration is present there.
However for many components, sufficient information is already available from their manifest file, such as the `main` key in a `bower.json` file.
We also have the package adapters which can take this info and a normalizer to normalize it.
The next step is thus to load extra config information directly via the package adapter (if library package is present there) and merge it with the info in the registry
before installing the full info in the local cache._

We are creating a new `config/enricher` to handle this. The `Enricher` can enrich a given config entry with extra information, typically via a package manager file.

_After the configs are cached they can be loaded from the cache. Currently it is only at the load step that
configs are normalized. This needs to be fixed, so that entries are all stored in a normalized form._

This will now be handled by the registry adapter, via the `BaseAdapter` class which now has a function `enrichAndNormalize`
which is called to enrich and normalize a config before it's installed.

```js
class BaseAdapter
  # ...
  install: (name) ->
    @installer!.install source: @enriched-config(name), target: @target-config(name)

  enriched-config: (name) ->
    @read-config name
    @enrich-and-normalize!
```

This is still a Work In Progress...

You are encouraged to extend the API as you see fit and integrate more of the API as CLI commands to improve
the overall user experience!

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

In fact, this is very similar to the [meteor](https://www.meteor.com/) package manager [atmosphere](https://atmospherejs.com/)
with *isomorph* packages. Libraries has a very similar goal

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

The global registry contains:

A single json file with keys for each library and values in the form of config Objects, very similar to a components file.

See `registry/adapter/local/pkg-adapter` for this.

For sample registries, see `/registry` such as `bower-libs.json`. The `libraries` library itself, will ship with these sample registries
 which can be used directly as a local registry and will used as a fallback (default) repo to be considered unless a match is found
 in another registry.

You can configure registries to be considered via your `.librariesrc` file
via the `registries` key.

On `library install`, the libraries you have selected which don't have a local library config in your local repo will
 be installed from a global registry.
 
You can then run `library build` to build the `imports.js` file which `libraries` will use to
apply on your `app` to do the magic imports! *Awesome 8>)* 

```js
(function() {
  module.exports = function(app) {
    app.import('dist/ember-validations');
    app.import('dist/ember-easyform');
    app.import('momentjs/index');
    app.import('dist/js/bootstrap.js');
    app.import('dist/css/bootstrap.css');
    app.import('dist/fonts/bootstrap.eof');
    app.import('dist/fonts/bootstrap.svg');
    app.import('dist/js/foundation.js');
    app.import('dist/css/foundation.css');
    app.import('dist/fonts/foundation.eof');
    app.import('dist/fonts/foundation.svg');
  }
}).call(this);
```

When you build, it will build an`xlibs/builds/imports-dev.js` if your current environment is `dev` and so on... 
This way you can better manage which libraries have been tested to go into production without overwriting them 
when in dev or test mode. Super bonus!

You can also split up configuration according to environment (`dev`, `test`, `prod`).

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

### Brocfile example

You can control which imports file you wish to load either directly via an options hash or 
indirectly via `process.env.environment`.  

```javascript
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

require('libraries').applyOn(app, {env: 'dev'});

module.exports = app.toTree();
```

### CLI support

- Add CLI interface to add/remove via CLI commands

Add a library to selection

`library select bootstrap`

Remove a library from selection

`library unselect bootstrap`

Install all library configs selected that are not part of local library configuration repo
Missing configurations are fetched from remote repo/repository and installed locally!

`library install`

Runs install to install any selected components without a config.
Build javascript imports from selected libraries, using local library configuration.

Save as javascript file, ready to be used via `require('libraries').applyOn(app);` in `Brocfile.js`
 
`library build` 
 
Please help out to make this an awesome experience and greatly enhance productivity for all of us... ;)

*Enjoy :)*

### gitignore

For typical project, you would decide which `imports-` files to share between team members and which to kep local.
the `imports-prod` would for sure not be in the `.gitignore`, but be the one that has been tested and approved to go
into production. The `imports-dev` and `imports-test` can be used for development and testing...  

## Roadmap

The next version of libraries will add the following features:

## Environment encapsulation*

Divide `xlibs` into `xlibs/dev`, `xlibs/test` and `xlibs/prod` and configure environments individually.
 
When your dev environment feels ready for testing...
 
`library transfer test` 

When your test environment is ready for production
 
`library transfer prod` 

This feature is ready for almost beta testing ;)

### Adapters

Include various adapters and infrastructure to support your own adapters.

### Async for maximum performance

Use `async` library to perform most operations asynchronously to massively increase performance!!
Especially important when using bower/component adapter to find the package config file from a remote 
repo or when installing configs from one or more remote registries...

### Normalizer

The files normalizer can be used to normalize a configuration entry for a package manager, 
such as the `component.json` or `bower.json` file. 

### Package manager adapters 

Comes with adapter functionality for package managers
Currently we include adapters for Component.js and Bower. Roll you own ;)

*Remote*

- Component.js
- Bower

*Local*

- Bower

### Registry adapters

Comes with adapter functionality for any registry you like. 
Currently we include adapters for Uri and local File. You are free to roll you own adapter ;)

- UriAdapter
- FileAdapter

The UriAdapter will find a component configuration from a remote registry such as a file in a Github repo.
It will then install the component configuration locally.

### Installation adapters

The installer adapters can install a component config in your local repository either as a single JSON file 
or into one big JSON file. You can even "roll your own" Install adapter to suit your needs if you like.

- FileInstaller
- JsonInstaller

### Loader adapters

Comes with loader adapters to load a config from each (or either) of the Installation targets of the Install adapters.
You can roll your own Loader adapter to suit your needs, to load a config from any source such as a Database etc.

- FileLoader
- JsonLoader
- CompositeLoader

The CompositeLoader will try to load a Component config using each of the registered loader adapters in succession until 
one of them succeeds in finding the requested Component config.

### Customization

The library API is very customizable. See the code for yourself! 

The `build` calls can each take a callback which allows you to fine-tune the output of 
any build, so as to not be hardcoded to be used for the Broccoli build process ;)
  
### License

MIT
