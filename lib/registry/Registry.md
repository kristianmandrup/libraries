# Registry

The Registry contains various classes that manage both the local Registry and contacting, extracting and 
installing component configurations from a remote Registry. 

It can also find configs from various package managers such as Bower and Component.js and normalize, 
then install those configuration in your local registry. 

### Package manager adaptors 

Comes with adapter functionality for package managers
Currently we include adapters for Component.js and Bower. Roll you own ;)

- Component.js
- Bower

The Package manager adapters can be found in the `registry/config/package` folder. 

### Package format normalization

The Package format normalizers are found in `registry/config/normalizer`

They can take a package format like:





### Registry adapters

Comes with adapter functionality for any registry you like. 
Currently we include adapters for Uri and local File. You are free to roll you own adapter ;)

- UriAdapter
- FileAdapter

The UriAdapter will find a Component configuration from a remote registry such as a file in a Github repo.
It will then install the Component configuration locally.

### Install adapters

The Install adapters can install a component config in your local repository either as a single JSON file 
or into one big JSON file. You can even "roll your own" Install adapter to suit your needs if you like.

- FileInstaller
- JsonInstaller

The Install adapters can currently be found in the `registry/config/installer` 

### Loader adapters

Comes with loader adapters to load a config from each (or either) of the Installation targets of the Install adapters.
You can roll your own Loader adapter to suit your needs, to load a config from any source such as a Database etc.

- FileLoader
- JsonLoader
- CompositeLoader

The CompositeLoader will try to load a Component config using each of the registered loader adapters in succession until 
one of them succeeds in finding the requested Component config.

### Local and Remote

The Registry also has a Local and Remote config loader. It is advised, to normally only use the Local loader.
The Remote loader, can directly load a config from a remote Registry, but it is recommended to instead install 
and cache these configs and then load them via the Local loader.