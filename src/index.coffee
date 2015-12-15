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
    output: 'master.css',
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
            if key == opts.master
              s = stylus file.contents.toString()
                .set 'filename', opts.output
                .include process.cwd() + '/' + metalsmith._directory + '/**/*'
              includes.push s.deps()...
              s.render (err, css) ->
                if err? then throw err
                new_file = key.replace opts.master, opts.output
                files[new_file] = file
                files[new_file].contents = new Buffer(css)
                delete files[key]
            else if key.indexOf(opts.master) == -1 and includes.find( (v) -> v.includes(key))?
              delete files[key]
            else
              s = stylus file.contents.toString()
                .set 'filename', key
                .include process.cwd() + '/' + metalsmith._directory + '/**/*'
              s.render (err, css) ->
                if err then throw err
                new_file = replaceExt key, opts.filter
                files[new_file] = files[key]
                files[new_file].contents = new Buffer(css)
                delete files[key]
          else
            s = stylus file.contents.toString()
              .set 'filename', key
              .include process.cwd() + '/' + metalsmith._directory + '/**/*'
            s.render (err, css) ->
              if err then throw err
              new_file = replaceExt key, opts.filter
              files[new_file] = files[key]
              files[new_file].contents = new Buffer(css)
              delete files[key]
    done()

module.exports = Stylus
