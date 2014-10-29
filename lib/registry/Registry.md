# Registry

The Registry contains various classes that manage both the local Registry and contacting, extracting and 
installing component configurations from a remote Registry. 

It can also find configs from various package managers such as Bower and Component.js and normalize, 
then install those configuration in your local registry. 

### Package manager adaptors 

Comes with adapter functionality for package managers
Currently we include adapters for [Component.js](https://github.com/componentjs/component) and [Bower](http://bower.io).
Please feel free to roll you own ;)

- Component.js
- Bower

The Package manager adapters can be found in the `registry/config/package` folder. 

### Package format normalization

Package format normalizers are found in `registry/config/normalizer`

They can take a package format like:

```js
files: ['x/y/z.js', 'ab/c/def.css']
```

and turn it into a "pretty" format, like:

```js
scripts: {
  files: ['x/y/z.js']
},
styles {
  files: ['ab/c/def.css']
}
```

Normalization is used to convert various package format file listing into a common `libraries` format.
This allows us to load a library configuration from any package format (bower, component etc.) or to write the
 registry in a "dirty" (simple) format and have the normalizer do the hard work.

### Registry adapters

Comes with adapter functionality for any registry you like. 
The Registry adapters are divided into local and remote adapters.
The local adapters can load a registry from a local file path location. Currently two local adapters are available:

- FileAdapter
- PkgAdapter

The `FileAdapter` currently tries to find an `index.js` file at the file path location and proceed to load each configuration as
 an individual `.json` file in the same path.

The `PkgAdapter` on the other hand, will load the registry from a (bower) package, by default the `libraries` package itself:
A bower library configuration would be found in:

`bower_components/libraries/registry/bower-libs.json`

The remote registry adapter is `UriAdapter` which currently only knows how to load a registry via github, applying the same strategy
as `PkgAdapter` except loading the json file remotely via HTTP GET.

The remote registry adapter will attempt to find a Component configuration and then install the Component configuration locally.
It should be easy to extend and customize to any remote registry provider such as for a different repo provider/protocol.

### Install adapters

The Install adapters can install a component config in your local repository either as a single JSON file 
or into one big JSON file. You can create your Install adapter to suit your needs.

- FileInstaller
- JsonInstaller

The Install adapters can currently be found in the `registry/config/installer` 

The Registry adapters use an Install adapter to install a library config into the local `libraries` Component configs cache.

### Loader adapters

*Local and Remote*

The Registry has a Local and Remote config loader. It is advised, to normally only use the Local loader.
The Remote loader, can directly load a config from a remote Registry, but it's recommended to instead install
and cache these configs and then load them via the Local loader.

The local loaders are divided into:

- FileLoader
- JsonLoader
- CompositeLoader

The CompositeLoader will try to load a Component config using each of the registered loader adapters in succession until 
one of them finds the requested Component config. It is recommended to use the Local CompositeLoader.

You can write your own Loader adapter to load a config from any source such as a Database etc.

### Installing a config

The `Registry` class contains an `install(name)` method which installs a library by name.
The Registry constructor takes an option hash with a `type` to signify the adapter to be used,
either `local` (default) or `remote`.

The default local adapter will by default be configured to load a library from the bower package manager,
using the "bower components" folder (by default in `bower_components`).

Furthermore, the `PkgAdapter` is the default adapter and will by default use the `libaries` package itself as
the package to load the registry from.

When a registry has been loaded, it is time to lookup a component config in the repository and
then install it in the libraries configs cache.

*Important*

_Currently the registry configs are installed "as is", which is only works if the full library configuration is present there.
However for many components, sufficient information is already available from their manifest file, such as the `main` key in a `bower.json` file.
We also have the package adapters which can take this info and a normalizer to normalize it.
The next step is thus to load extra config information directly via the package adapter (if library package is present there) and merge it with the info in the registry
before installing the full info in the local cache._

The Registry config installer is responsible for installing a config into the libraries cache.
By default a local json installer will be used, which stores configs into a single json file.

After the configs are cached they can be loaded from the cache.
Currently it is only at the load step that configs are normalized.
This needs to be fixed, so that entries are all stored in a normalized form.

### Multiple registries

There is also a CompositeRegistry available, which makes it possible to group multiple registries into a composite and all be treated
as a single registry. This makes it possible for the community to share/reuse registries or for a company to integrate private
registries with public ones ;)