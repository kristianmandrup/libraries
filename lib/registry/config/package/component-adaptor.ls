# knows how to search for a component and convert into a normalized library component config

co      = require 'co'
search  = co(require 'component-search2')

warning = (msg) ->
  throw Error msg

registry =
  search: (query, cb) ->
    search query, (err, pkgs) ->
      cb err if err
      cb 'no matching components found' if !pkgs.length
      cb null, pkgs

Q = require 'q'

module.exports = class ComponentAdapter
  (@name, @options = {}) ->
    @validate!
    @repos.push @options.repo if @options.repo
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of bower component must be a String, was: #{util.inspect @name}"

  adapted:
    main: {}
    scripts: {}
    styles: {}
    fonts: {}
    images: {}
    files: {}

  configure: (pkg) ->
    for key of @adapted
      @adapted[key].files = pkg[key] if pkg[key]

  retrieve: ->
    @find!.promise.then (pkgs) ~>
      @configure pkgs[0]

  query: ->
    @_query ||=
      text: @name
      limit: 5
      maxage: 1000 * 3600
      verbose: true

  # https://github.com/componentjs/search.js/blob/master/node/search.js
  # https://github.com/componentjs/search.js/blob/master/client/search.js
  find: ->
    deferred = Q.defer!
    registry.search @query!, deferred.make-node-resolver!
    deferred

  # See https://github.com/componentjs/component/wiki/Spec

  # It is recommended that you use "index.js" for the main component file,
  # however if you use another filename, you MUST define a "main" field for that.

  # ["index.js", "template.js"],
  # The scripts field explicitly specifies the JavaScript files that this component relies on. These MUST be regular JavaScript, not CoffeeScript, LiveScript or similar compiled languages.

  # The styles field explicitly specifies the stylesheets for this component, and follow the same
  # rules as scripts, compilers such as Stylus or SASS may be used to compile down to
  # regular CSS, however it is not recommended.
  # ["tip.css"]

  # The images field MUST be supported and fetched upon installation,
  # this allows component build tools to rewrite stylesheet url()s in order to
  # accommodate various file serving techniques.

  # same as for images

  # In the future we will classify more file types, however for those which are not treated
  # uniquely such as fonts may be placed in a files array to aid build and installation tools.
