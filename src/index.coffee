{basename, dirname, extname} = require 'path'
stylus = require 'stylus'

extend = (object, properties) =>
  for key, val of properties
    object[key] = val
  object

Stylus = (options) ->
  opts = extend
    master: null,
    output: 'master.css'
  , options
  return (files, metalsmith, done) ->
    for key, file of files
      do (key, file) ->
        if opts.master?
          if key == opts.master
            s = stylus file.contents.toString()
              .set 'filename', opts.output
              .include process.cwd() + '/' + metalsmith._directory + '/**/*'
            s.render (err, css) ->
              if err? then throw err
              new_file = key.replace opts.master, opts.output
              files[new_file] = file
              files[new_file].contents = new Buffer(css)
              delete files[key]
          else if key.indexOf(opts.master) == -1 then delete files[key]
        else
          s = stylus file.contents.toString()
            .set 'filename', key
            .include process.cwd() + '/' + metalsmith._directory + '/**/*'
          s.render (err, css) ->
            if err then throw err
            new_file = key.replace '.styl', '.css'
            files[new_file] = files[key]
            files[new_file].contents = new Buffer(css)
            delete files[key]
    done()

module.exports = Stylus
