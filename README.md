# Libraries

Libraries loader for Broccoli

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

libraries = require './libraries'
libraries = new Libraries(app)
libraries.importAll()

# or passing custom options 

libraries = new Libraries app, file: './imports/libraries.json', config: {vendor: 'vendor/dev'}
libraries.importAll() 
```

### Brocfile example

```javascript
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

// Use `app.import` to add additional libraries to the generated

manager = require('libraries')
libraries = new manage.Libraries(app)
libraries.importAll(app);

module.exports = app.toTree();
```

## Configuration

For the libraries to be loaded, you must create a `libraries.json` file in an `imports/` folder of your project.

To override the default config file location use `require('libraries').importAll(app, 'path/to/libraries.json');`

Example configuration:

```javascript
// imports/libraries.json
{
    "config": {
        "vendor": "vendor/prod"
    },
    "bower": {
        "libs": [
            "ember-validations/dist/ember-validations",
            "ember-easyform/dist/ember-easyform"
        ],
        "remap": {
            "famous/core": "famous/core",
            "moment": "moment/index"
        }
    },
    "vendor": {
        "libs": [
            "x/dist/x",
            "y/dist/y"
        ],
        "remap": {
            "jquery/core": "dist/jquery/core"
        }
    }
}
```

### Adding configuration libs and remaps via API

```
libraries.addLibs 'chaines', ['sdfds/sddsg.js']
libraries.save()

# or save to specific file
libraries.save(my-filepath)

# print full libraries configuration (for debugging)
libraries.print()

# to any printer function which takes a string argument
libraries.print console.log
```

### Removing configuration libs and remaps via API

```javascript
libraries.removeLibs 'chaines', ['sdfds/sddsg.js']
libraries.removeRemap 'bower', 'jquery/core'
libraries.removeRemaps 'bower', ['jquery/core', 'famous/core']
libraries.print()
libraries.save()
```

### Dummy App and Debugging

To print all `app.import` statements to via `console.log` (default)

```javascript
manager   = require('libraries')
libraries = new manage.Libraries manager.debug-app()
libraries.importAll()

# or use any other function that takes a string 
debug-app(console.log)
```

Enjoy :)

### Future (ideas and thoughts)

Please provide feedback to this section...

- Change libs to object format

Instead of:

```javascript
bower: {
  libs: ['asf/dist/asf-0.3', 'zebra/lib/main']
  },
```  

Change to a format where each key is the id (folder name) of the library.

```javascript
bower: {
  libs: {
    asf: 'dist/asf-0.3', 
    zebra: 'lib/main'
  },
```  


- Add support for components

For "custom" components, we can let users specify them like this, then later turn them into real components with their own `component.json` file.

```javascript
components: {
  bootstrap: {
    script: 'dist/bootstrap.js'
    styles: [...]
    fonts: [...]
  },
  ...
```

- Add support for [ComponentJS](https://github.com/componentjs/component) 
- Also support [Duo](http://duojs.org/) which uses `componenet.json` as well... 

Some quotes:

"Component's integrated build system allows you to simply include one script and one stylesheet in your page.
There's no juggling `<script src="bower_components/jquery"><script>` calls and such."

"Component, by default, uses the CommonJS module system. The major benefit of this is that there are no boilerplate callbacks. 
However, as of `1.0.0`, *Component supports ES6 modules natively.*"

Could we make component entries like this, after iterating through the components installed?
 
Looks like we can use [https://github.com/duojs/duo/blob/master/docs/api.md]


```javascript
var duo = new Duo(__dirname); //Initialize a new Duo instance with a path to the package's root directory
duo.entry(file) // Specify the entry file that Duo will traverse and transform.
``

"`duo.installTo(path)` - Set the path to the install directory, where dependencies will be installed. Defaults to `./components`"

[normalize](https://normalize.github.io/) is used to push code directly via *SPDY push* and thus does not require a build/bundle step,  
it can be done however using [nlz](https://github.com/normalize/nlz). Normalize totally circumvnts the build step so it makes no sense to even
 try to support this. Can be used as a bonus directly from within your javascript files if you wish (yes, they even have Ember examples!).

"The major difference between Bower and Component: `component.json` is more strict and opinionated: 
all files listed in `component.json` are assumed to be mandatory. 
On the other hand, files listed in a `bower.json` are generally optional."

This means that we can directly use the files listed in `component.json` for any component :) 

```javascript
{
  "name": "duo-component",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "component/tip": "1.x",
    "jkroso/computed-style": "0.1.0"
  }
}
```

From this, I gather it would be possible to download the `component.json` file from github for each component referenced via their special syntax (we should extract the code to do this!) 
to folder such as: `'components/_manifests/' + name'`. Then create an `index.js` file with a `require(dependency)` for each dependency.

To use each such manifest to install the component (files) locally, we could use `duo.entry('components/_manifests/' + component + '/index.js')` and then `duo.installTo('./components')`. 

This sure feels like sidestepping the whole idea of component/duo which are all about avoiding the whole build/bundle step, however it is the only way I see that
 it can work with the current Broccoli workflow. Anyhow, it's all stop-gap measures until we have broad native ES6 module support in the browsers...

- Add support for other client package managers such as [component](https://github.com/component), see [repo](https://github.com/componentjs/component)
- Add a global registry with pre-configured configurations for common components and libs
- Allow local registry override and extension of global registry via `Object.extend`
- Enable [ember-config](https://github.com/kristianmandrup/ember-config) generator to both add and remove libs and components easily using registry
- Add CLI interface to add/remove via CLI commands

`library add component bootstrap`

`library remove component bootstrap`

`library add component bootstrap:fonts`

`library add lib jquery:css`

`library add components jquery-ui bootstrap`

`library remove components jquery-ui bootstrap`
 
Please help out to make this an awesome experience and greatly enhance productivity for all of us... ;)

*Enjoy :)*

### License

MIT
