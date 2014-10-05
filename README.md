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

### Future

- Add support for components.

```javascript
components: {
  bootstrap: {
    script: 'dist/bootstrap.js'
    styles: [...]
    fonts: [...]
  },
  ...
```

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
