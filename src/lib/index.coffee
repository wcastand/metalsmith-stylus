basename = require 'path'.basename
dirname = require 'path'.dirname
extname = require 'path'.extname
stylus = require 'stylus'

class Stylus
  contructor: (options) ->
    class Middleware
      constructor:(options) ->
        @opts = @extend
          master: null,
          output: 'master.css'
        , options
      extends: (object, properties) ->
        for key, val of properties
          object[key] = val
        object

      plugin: (files, metalsmith, done) ->
        for file in files
          do (file) ->
            if @opts.master?
              if basename(file) == @opts.master
                s = stylus files[file].contents.toString()
                  .set 'filename', opts.output
                  .include process.cwd() + '/src/' + dirname(file)
                s.render (err, css) ->
                  if err? then throw err
                  new_file = file.replace @opts.master, @opts.output
                  files[new_file] = files[file]
                  files[new_file].contents = new Buffer(css)
                  delete files[file]
              else if file.indexOf(@opts.master) == -1 then delete files[file]
            else
              s = stylus files[file].contents.toString()
                .set 'filename', basename(file)
                .include process.cwd() + '/src/' + dirname(file)
                .render (err, css) ->
                  if err then throw err
                  file.replace '.styl', '.css'
                  files[file].contents = new Buffer(css)
        done()

    styl = new Middleware options
    return styl.plugin.bind(styl)

module.exports = Stylus
