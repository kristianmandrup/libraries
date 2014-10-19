# knows how to read a bower.json file and convert into a normalized library component config

module.exports = class BowerAdapter implements FileIO
  (@name, @options = {}) ->
    @validate!
    @repos.push @options.repo if @options.repo
    @

  validate: ->
    unless typeof! @name is 'String'
      throw new Error "Name of bower component must be a String, was: #{util.inspect @name}"

  adapted: {}

  adapt: ->
    for key in ['main', 'scripts', 'styles', 'images', 'fonts', 'files']
      @adapted[key] = @[key]!
    @adapted

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
