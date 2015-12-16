{basename, dirname, extname} = require 'path'
stylus = require 'stylus'

extend = (object, properties) =>
  for key, val of properties
    object[key] = val
  object

filter = (file, filters) =>
  for f in filters
    ff = new RegExp f
    if ff.test file then return true
  return false

replaceExt = (file, filters) =>
  for f in filters
    ff = new RegExp f
    if ff.test file
      return file.replace(ff, '.css')

Stylus = (options) ->
  opts = extend
    master: null,
    outputDir: null,
    output: null,
    filter: '.styl, .stylus'
  , options
  f = opts.filter.split ','
  for k, v of f
    f[k] = v.replace(' ', '') + '$'
  opts.filter = f

  return (files, metalsmith, done) ->
    includes = []
    for key, file of files
      if filter key, opts.filter
        do (key, file) ->
          if opts.master?
            if key.indexOf(opts.master) isnt -1
              if opts.output? and opts.outputDir?
                new_file = opts.outputDir + '/' + opts.output
              else if opts.output? and not opts.outputDir?
                new_file = replaceExt(key, opts.filter)
              else if opts.outputDir? and not opts.output?
                new_file = opts.outputDir + '/' + replaceExt(basename(key), opts.filter)
              s = stylus file.contents.toString()
                .set 'filename', new_file
                .include metalsmith._directory + '/**/*'
              s.render (err, css) ->
                if err? then throw err
                files[new_file] = file
                files[new_file].contents = new Buffer(css)
                delete files[key]
              includes.push s.deps()...
            else if key.indexOf(opts.master) is -1 and includes.find( (v) -> v.indexOf(basename(key)))?
              delete files[key]
            else
              new_file = if opts.outputDir? then opts.outputDir + '/' + replaceExt(key, opts.filter) else replaceExt(key, opts.filter)
              s = stylus file.contents.toString()
                .set 'filename', key
                .include metalsmith._directory + '/**/*'
              s.render (err, css) ->
                if err then throw err
                files[new_file] = files[key]
                files[new_file].contents = new Buffer(css)
                delete files[key]
          else
            new_file = if opts.outputDir? then opts.outputDir + '/' + replaceExt(key, opts.filter) else replaceExt(key, opts.filter)
            s = stylus file.contents.toString()
              .set 'filename', key
              .include metalsmith._directory + '/**/*'
            s.render (err, css) ->
              if err then throw err
              files[new_file] = files[key]
              files[new_file].contents = new Buffer(css)
              delete files[key]
    done()

module.exports = Stylus
