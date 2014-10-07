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

![Package management](http://upload.wikimedia.org/wikipedia/commons/2/22/Pms.svg "Package management")

Links:

- http://www.huffingtonpost.com/alex-ivanovs/5-package-managers-for-no_b_5880116.html
- http://blog.slant.co/post/95896285907/finding-a-winning-workflow-for-frontend-development
- http://infomatrix-blog.herokuapp.com/post/modules-modules-everywhere

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

For "custom" components, we can let users specify them something like this...
Question: Is this too much complexity to be worth it? If we can have a registry of it and make it easy to auto-populate for most 
libraries it should be worth it. Makes it much easier to manage and allows for tooling support to manage it.

```javascript
components: {
  bootstrap: {
    items: {
      dir: 'dist',
      scripts: {
        baseDir: 'js', // relative ie. 'dist/js'
        files: ['bootstrap.js'] // becomes 'bootstrap/dist/js/bootstrap.js'
      },
      styles: {
        dir: 'css',
        files: [...]
      }
      fonts: {
        dir: 'fonts',
        files: [...]
      }
    },
    remap: 'bootstrap3'
  },
  ...
```

Ideally it would be nice if we could auto-populate this somehow, either by lookup in a registry or by parsing the downloaded components in the folders
such as `bower_components` folder. At least it would be nice to generate empty placeholders :)

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

Design:

```
- xlibs
  libraries.json
  - components
    - bower
      components.json
    - vendor
      components.json        
```

```
// libaries.json
{
  components: {
    bower: [
      'bootstrap',
      ...
    ],
    vendor: [
      ...
    ]
  }
}
```


- Add support for other client package managers such as [component](https://github.com/component)? 

- Add a global registry with pre-configured configurations for common components and libs
- Allow local registry override and extension of global registry via `Object.extend`
- Enable [ember-config](https://github.com/kristianmandrup/ember-config) generator to both add and remove libs and components easily using registry

### Jam support?

[Jam](http://jamjs.org/) is similar to Bower in its functionality.

`jam search` to find jam packages

```bash
$ jam install jquery
...
updating jam/jam.json
```

This will download the latest version of jQuery and put it into `./jam/jquery/jquery.js`. 
By default all packages are installed to `./jam`. Now, we could just include that script manually, 
but Jam comes with *RequireJS* to manage this for us.

`<script src="jam/require.js"></script>`

Then use it...

```javascript
require(['jquery'], function () {
 ...
}); 
```

However, according to *@tomdale*, [AMD is not the answer](http://tomdale.net/2012/01/amd-is-not-the-answer/)
Could we perhaps use *amdclean* to strip this away and repack?

### Ender support?

- http://wibblycode.wordpress.com/2013/01/01/the-state-of-javascript-package-management/

"The created library exposes a global variable `$` with properties defined by the component packages. Once your library has been started you use ender add and ender remove to manage the components that it provides. The library is written into `ender.js` and `ender.min.js`.
*Ender* piggybacks off of the *npm registry*, with each *Ender* package being an npm package. To signify that an npm module is compatible you add the `‘ender’` keyword to `package.json"

### Volo support?

"Volo can be used much like bower to simply install the contents of a package, but it also includes a project automation/build system and *can automatically turn installed packages into AMD modules*
Volo uses *Github* as its backend – a package is a Github repository and volo add will use the Github search API to find packages if you only provide a name or keyword. You can specify a full repository name with `volo add <username>/<project name>`, e.g. `volo add jquery/jquery`."

`volo add [flags] [archive] [localName]`

`-amdoff`: Turns off AMD conversion for when the project is AMD and the dependency being added is not AMD/CommonJS. 

For the directory in which add is run, it will look for the following to know where to install:

Looks for a `volo.baseDir` `package.json` property.
Looks for a `js` directory
Looks for a `scripts` directory

### Webmake?

Alternative to Browserify!

[webmake](https://github.com/medikoo/modules-webmake) - Bundle CommonJS/Node.js modules for web browsers.

Require CSS and HTML files same way. Webmake allows you to require them too, which makes it a full stack modules bundler for a web browser.

Hmm... actually it looks better than Browserify in many aspects I would say ;)

[comparison-with-other-solutions](https://github.com/medikoo/modules-webmake#comparison-with-other-solutions)

"When comparing with other CJS bundlers, main difference would be that Webmake *completely follows resolution logic as it 
works in `node.js`*. It resolves both packages and modules exactly as `node.js`, and it doesn't introduce any different ways to do that. 
Thanks to that, you can be sure that your modules are runnable in it's direct form both on server and client-side."

"... noticeably faster solution"


### CLI support

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
