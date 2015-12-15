# metalsmith-stylus

[![build status][travis-image]][travis-url]

A [Stylus][stylus] plugin for [Metalsmith][metalsmith].

#WORK IN PROGRESS

## Installation

```
npm install metalsmith-styl
```

## Usage

```js
//Without params
var stylus = require('metalsmith-stylus')

Metalsmith(__dirname)
  .use(stylus())
  .build()

//With params
var stylus = require('metalsmith-stylus')

Metalsmith(__dirname)
  .use(stylus({
    master:'master.styl',
    output: 'app.css',
    filter: '.styl, .stylus, .test'
  }))
  .build()
```

### Options

Use any or all of the following:

#### `filter`

extension who need to be processed

default: .styl, .stylus

#### `master`

Name of the master file.
file included in this one will not be rendered

default: null

#### `output`

Name of the file in your build.
Use only if master is specified.

default: master.css

## Todo

  - Create npm package

## Tests

```
$ mocha
```

## License

MIT License, see [LICENSE](https://github.com/joaoafrmartins/metalsmith-coffee/blob/master/LICENSE.md) for details.

[metalsmith]: http://www.metalsmith.io/
[stylus]: http://stylus-lang.com/
[travis-image]: https://travis-ci.org/wcastand/metalsmith-stylus.svg?branch=master
[travis-url]: https://travis-ci.org/wcastand/metalsmith-stylus
