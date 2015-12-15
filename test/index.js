var assertDir = require("assert-dir-equal");
var resolve = require('path').resolve;


var stylus = require("../");
var metalsmith = require('metalsmith');

describe("Metalsmith-stylus", function () {
  it("should compile stylus files without params", function (done) {
    var source = 'test/fixtures/basic'
    var target = 'test/fixtures/basic/build'
    var expected = 'test/fixtures/basic/expected'
    metalsmith(source)
      .source('src')
      .destination('build')
      .use(stylus())
      .build(function (err) {
        if (err) return done(err)
        assertDir(expected, target)
        return done(null)
      });
  });
  it("should compile stylus files with params", function (done) {
    var source = 'test/fixtures/complexe'
    var target = 'test/fixtures/complexe/build'
    var expected = 'test/fixtures/complexe/expected'
    metalsmith(source)
      .source('src')
      .destination('build')
      .use(stylus({
        master: 'master.styl',
        output: 'master.css',
        filter: '.styl, .stylus, .test'
      }))
      .build(function (err) {
        if (err) return done(err)
        assertDir(expected, target)
        return done(null)
      });
  });
});
