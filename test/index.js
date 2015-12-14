var assertDir = require("assert-dir-equal");
var resolve = require('path').resolve;


var stylus = require("../");
var metalsmith = require('metalsmith');

describe("Metalsmith-stylus", function () {
  it("should compile stylus files", function (done) {
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
});
