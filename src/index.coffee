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
    for file, content of files
      do (file, content) ->
        if opts.master?
          if basename(file) == opts.master
            s = stylus files[file].contents.toString()
              .set 'filename', opts.output
              .include process.cwd() + '/src/' + dirname(file)
            s.render (err, css) ->
              if err? then throw err
              new_file = file.replace opts.master, opts.output
              files[new_file] = files[file]
              files[new_file].contents = new Buffer(css)
              delete files[file]
          else if file.indexOf(opts.master) == -1 then delete files[file]
        else
          s = stylus files[file].contents.toString()
            .set 'filename', basename(file)
            .include process.cwd() + '/src/' + dirname(file)
            .render (err, css) ->
              if err then throw err
              new_file = file.replace '.styl', '.css'
              files[new_file] = files[file]
              files[new_file].contents = new Buffer(css)
              delete files[file]
    done()

module.exports = Stylus
