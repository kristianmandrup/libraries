## Design

```
.xlibsrc
- xlibs
  - imports.dev.js (compiled) 
  - config.json  
  - selected (list)
  - components.json (used if no components folder)
  - components
     + bootstrap.json
     + foundation.json
    ...
  
```

NOTE: `imports.js` should be added to `.gitignore`. When a release is ready, generate a `xlibs/imports.js` file via CLI
 `library generate imports` or `library g test:imports` (generates `imports.dev.js`). 
When loaded from Brocoli, it will try to load imports.js if enviroment is PROD, otherwise `imports.dev.js` for DEV environment etc. 

```
# .gitignore
xlibs/imports-dev.js
xlibs/imports-test.js
```

### Structuring component configs

Instead of having individual files for each component we could have one file `components.json`. 
One file should be manageable up to at least 10 components. Most project don't have more than this (at least yet!?).

If `components.json` exists, this file will be used, otherwise the individual json config files in the `components/` folder.

.xlibsrc
```javascript
{
  build: 'auto' // build after any 'add' or 'remove' CLI command
  registries: [
    'github:kristianmandrup/component-registry',
    'github:my-private/component-registry',
    'file:./registry/main.json',
    ...
  ]
}
```
  
```javascript  
// libs.js (compiled)
  
app.import("bower_components/bootstrap/dist/bootstrap");
app.import(...);
app.import(...);
```

From `Brocfile.js`

```javascript
libraries.import();
```

Will use the appropriate `imports-<env>.js` file depending on environment.

`libs-selected` a simple text file, where each line is a library to include :) 

```  
bootstrap
datepicker
...
```

`config.json` contains configurations for all the simple (or custom) libraries

```javascript  
// config.json
{
  bower: {
    "components": [
      "bootstrap", 
      ...
    ],
    "libs: {    
      "datepicker": {"date": "dist/datepicker.js"}, // remap to date
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
```

The `components` entry is used to link the list of components as belonging to *bower*.

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
    },
    dependencies: ["styleout"]
}
```

Component configs can be downloaded from the registry at [component-registry](https://github.com/kristianmandrup/component-registry.git)

*Dependencies*

Any dependency listed in dependencies should result in a `library add <dependency>` so the dependency is added if it isn't selected yet.
What about removal. Should we track dependencies? What if it is used by another components?
Gets too complex... Not worth it. Developers must manage dependencies beyond this themselves.

### Registry

```javascript
// index.json
{
  registry: [
    'bootstrap'
  ]
  ...
}
...
```

```
index.json
bootstrap.json
...
```

### CLI

`library update registry`
 
 Goes through `selected` file and checks each entry if it's a component by making a lookup in the registry `index.json` file (see below). 
 
 If it's a component, it check if it has a component config file in `components/ folder.
 If not, it downloads the component config from the registry.
 
 `library build`
 
 Will run `library update registry` and then run `libraries.importSelected()` which will generate the `imports.js` file
  from the `selected` file.
 
`library add bootstrap`

Adds an entry `'bootstrap'` to `selected` file if not present. 
Then checks `config.json` to see if config is there. 
If no config entry:

- check if is a component (via registry) or just a library 
 
If library (not component): it will add `"bootstrap": "dist/bootstrap.js"` entry as a placeholder by default.

`library add lib:bootstrap` (no component check)

If component, it will download component config.

`library add cmp:bootstrap` - downloads bootstrap component config from registry if not present 
`library rm cmp:bootstrap` - removes bootstrap component config from registry 
  
`library add bootstrap index.js` - will set the entry to `"bootstrap": "index.js"` 

`library rm bootstrap` - will remove entry from `selected` file.
  
`library clean registry` - cleans registry from any components not currently selected in `selected` file.
`library clean config` - cleans `config.json` and component registry based on `selected` file.

`library install` - will run through entrie in `selected` file and then use `config.json` to validate if files exist.
Will report which libs are missing. For libs or components missing, it will download via Bower etc. as required.
Then make a final report if all config entries match an installed lib.

### What do we gain?

The problem with the previous approach has been, that you have to copy paste javascript statements with full string paths 
into your Brocfile. There is no easy/efficient way to maintain this. 

The approach has so far been to wrap a Bower component with an Ember CLI addon, and then add the same statements in the `'included'` hook.
This is really bad practice, not what Ember CLI addons were meant for. Addons should be reserved for functionality that applies 
app files or blueprints to a project and perhaps configures/injects certain aspects of the app, not for injecting Bower files.

The approach sketched here allows tooling, such as the library CLI and for generators such as ember-config to add/remove libraries simply by 
using the libraries API to operate on the JSON structure. Also, by having a component registry, we can share conventions making it easier to
  share code/configurations between projects.
