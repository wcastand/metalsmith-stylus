path = require 'path'
resolve = path.resolve

assertDirEqual = require 'assert-dir-equal'
metalsmith = require 'metalsmith'
stylus = require '../'

describe 'metalsmith-stylus', () ->
  it 'should compile stylus file', (done) ->
    source = resolve './test/fixtures/basic/'
    target = resolve './test/fixtures/basic/build'
    expected = resolve './test/fixtures/basic/expected'
    metalsmith source
    .use stylus()
    .build (err) ->
      if err then done err
      assertDirEqual expected, target
      done()
