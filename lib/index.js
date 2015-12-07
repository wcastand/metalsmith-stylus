// Generated by CoffeeScript 1.10.0
(function() {
  var Stylus, basename, dirname, extname, stylus;

  basename = require('path'.basename);

  dirname = require('path'.dirname);

  extname = require('path'.extname);

  stylus = require('stylus');

  Stylus = (function() {
    function Stylus() {}

    Stylus.prototype.contructor = function(options) {
      var Middleware, styl;
      Middleware = (function() {
        function Middleware(options) {
          this.opts = this.extend({
            master: null,
            output: 'master.css'
          }, options);
        }

        Middleware.prototype["extends"] = function(object, properties) {
          var key, val;
          for (key in properties) {
            val = properties[key];
            object[key] = val;
          }
          return object;
        };

        Middleware.prototype.plugin = function(files, metalsmith, done) {
          var file, fn, i, len;
          fn = function(file) {
            var s;
            if (this.opts.master != null) {
              if (basename(file) === this.opts.master) {
                s = stylus(files[file].contents.toString()).set('filename', opts.output).include(process.cwd() + '/src/' + dirname(file));
                return s.render(function(err, css) {
                  var new_file;
                  if (err != null) {
                    throw err;
                  }
                  new_file = file.replace(this.opts.master, this.opts.output);
                  files[new_file] = files[file];
                  files[new_file].contents = new Buffer(css);
                  return delete files[file];
                });
              } else if (file.indexOf(this.opts.master) === -1) {
                return delete files[file];
              }
            } else {
              return s = stylus(files[file].contents.toString()).set('filename', basename(file)).include(process.cwd() + '/src/' + dirname(file)).render(function(err, css) {
                if (err) {
                  throw err;
                }
                file.replace('.styl', '.css');
                return files[file].contents = new Buffer(css);
              });
            }
          };
          for (i = 0, len = files.length; i < len; i++) {
            file = files[i];
            fn(file);
          }
          return done();
        };

        return Middleware;

      })();
      styl = new Middleware(options);
      return styl.plugin.bind(styl);
    };

    return Stylus;

  })();

  module.exports = Stylus;

}).call(this);