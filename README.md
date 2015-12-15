# metalsmith-stylus

[![build status][travis-image]][travis-url]

A [Stylus][stylus] plugin for [Metalsmith][metalsmith].

#WORK IN PROGRESS

## Installation (not available)

```
npm install metalsmith-stylus
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
    output: 'app.css'
  }))
  .build()
```

### Options

Use any or all of the following:

#### `master`

Name of the master file (the one containing the includes)

#### `output`

Name of the file in your build

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
