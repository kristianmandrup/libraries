# Libraries

Libraries loader for Broccoli or similar library loaders or importers.

## Why?

This small project was created in response to ember-cli [#2177](https://github.com/stefanpenner/ember-cli/issues/2177).
It aims to make it easier and more flexible to configure libraries to be imported by Broccoli. 

Configuration is now externalised. Libraries can be grouped by category. We can configure a simple directory alias mechanism etc.
 We can even include automatic support for remapping.

Using a JSON format we can allow (code) generators to automatically process, append or remove libraries as needed 
from the JSON structure ;)

## Usage example

Here simulating the app object and doing `console.log` of the 
commands that the app object would normally execute on `app.import`

```coffeescript
app =
  import: (location) ->
    console.log 'app.import("' + location + '");'
  bowerDirectory: 'bower_components'

libraries = require './libraries'
libraries.importAll app

# or passing custom options 

libraries.importAll app, file: './imports/libraries.json', config: {vendor: 'vendor/dev'}
```

### Brocfile example

```javascript
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

// Use `app.import` to add additional libraries to the generated

require('libraries').importAll(app);

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

Enjoy :)

### License

MIT
