see [repo](https://github.com/componentjs/component)

- Add support for [ComponentJS](https://github.com/componentjs/component) 
- Also support [Duo](http://duojs.org/) which uses `componenet.json` as well... 

Some quotes:

"Component's integrated build system allows you to simply include one script and one stylesheet in your page.
There's no juggling `<script src="bower_components/jquery"><script>` calls and such."

"Component, by default, uses the CommonJS module system. The major benefit of this is that there are no boilerplate callbacks. 
However, as of `1.0.0`, *Component supports ES6 modules natively.*"

Every component, module, and app needs an entry point. In general, this is the `index.js` file or whatever is listed as `main`. However, you'll notice that many examples have a `component.json` that look like this:

```javascript
{
  "name": "app",
  "locals": ["boot"],
  "paths": ["lib"]
}
```

That is, there's no `.scripts`, and a single `boot` *local*. What this means is that that the *entry point is deferred to boot*, so the *build will automatically require('boot') instead of require('app')*. The main reason for doing so is to avoid having any files at the top of your directory, which makes it cleaner.

Could we use this mechanism to install the components locally? Then make component entries like this, after iterating through the components installed?
 
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

You can search the available components with `component search` 

From this, I gather it would be possible to download the `component.json` file from github for each component referenced via their special syntax (we should extract the code to do this!) 
to folder such as: `'components/_manifests/' + name'`. 

Then create an `index.js` file with a `require(dependency)` for each dependency.

To use each such manifest to install the component (files) locally, we could use `duo.entry('components/_manifests/' + component + '/index.js')` and then `duo.installTo('./components')`. 

Alternatively perhaps us of [resolver.js](https://github.com/componentjs/resolver.js) - Resolve a component's dependency tree.
- Validates and normalizes `component.json`
- Supports installing components
- Supports globs for both remote and local components
- Supports semver resolution for dependencies


This sure feels like sidestepping the whole idea of component/duo which are all about avoiding the whole build/bundle step, however it is the only way I see that
 it can work with the current Broccoli workflow. Anyhow, it's all stop-gap measures until we have broad native ES6 module support in the browsers...
