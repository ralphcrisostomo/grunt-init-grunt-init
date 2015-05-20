###
 * grunt-init-{%= name %}
 * http://ralphcrisostomo.net
 *
 * Copyright (c) 2014 Ralph Crisostomo
 * Licensed under the MIT license.
###

'use strict'

# Basic template description.
exports.description = 'Create a Node.js module including Nodeunit unit tests.'

# Template-specific notes to be displayed before question prompts.
exports.notes = '_Project name_ shouldn\'t contain "node" or "js" and should ' +
  'be a unique ID not already in use at search.npmjs.org.'

# Template-specific notes to be displayed after question prompts.
exports.after = 'You should now install project dependencies with _npm ' +
  'install_. After that you may execute project tasks with _grunt_. For ' +
  'more information about installing and configuring Grunt please see ' +
  'the Getting Started guide:' +
  '\n\n' +
  'http:#gruntjs.com/getting-started'

# Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*'

# The actual init template.
exports.template = (grunt, init, done) ->

  # Underscore utilities
  _ = grunt.util._

  init.process {type: 'node'}, [
    # Prompt for these values.
    init.prompt('name')
    init.prompt('description')
    init.prompt('version')
    init.prompt('repository')
    init.prompt('homepage')
    init.prompt('bugs')
    init.prompt('licenses')
    init.prompt('author_name')
    init.prompt('author_email')
    init.prompt('author_url')
    init.prompt('node_version', '>= 0.12.0')

  ], (err, props) ->

    props.bin = {}
    props.bin["#{props.name}"] =  "./build/bin/#{props.name}"
    props.main = './build/lib/main'
    props.keywords = []
    props.preferGlobal = true
    props.dependencies =
      "commander": "^2.8.1"

    props.devDependencies =
      "chai": "^2.3.0"
      "coffee-script": "^1.9.2"
      "gulp": "^3.8.11"
      "gulp-chmod": "^1.2.0"
      "gulp-clean": "^0.3.1"
      "gulp-coffee": "^2.3.1"
      "gulp-coffeelint": "^0.4.0"
      "gulp-insert": "^0.4.0"
      "gulp-mocha": "^2.0.1"
      "gulp-rename": "^1.2.2"
      "gulp-uglify": "^1.2.0"
      "run-sequence": "^1.1.0"


    # Files to copy (and process).
    files = init.filesToCopy(props)


    # Add properly-named license files.
    init.addLicenseFiles(files, props.licenses)

    # Actually copy (and process) files.
    init.copyAndProcess(files, props)

    # Generate package.json file.
    init.writePackageJSON 'package.json',  props, (pkg, props) ->
      pkg['scripts'] =
        test: 'gulp test'
        #postinstall: 'git flow init && git add . && git commit -am "init commit"'
      pkg

    # All done!
    done()



