<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A simple parser combinator library heavily inspired by 
[nom](https://github.com/rust-bakery/nom).
This library is more of a personal excersise to learn the Dart
programming language. It is not meant to be a full
rewrite of nom, since i'm not planning on expanding it a whole
lot. It is not particularly optimized for speed and cannot be
used with binary data.

It is just a quick and dirty library to create string parsers.

## Features
Allows you to write parsers using simple combinators.
Here are the parsers and combinators you can use.

Parsers:
- tag
- take
- takeTill *
- takeUntil *
- takeWhile *
- takeAll *

* Also has a variant that needs to have at least one character matched.

Combinators:
- opt
- alt
- map
- list

## Usage

Example on how to match markdown links:

```dart
final parser = list([
  tag("["),
  takeUntil("]"),
  tag("]("),
  takeUntil(")"),
  tag(")")
]);

var (value, tail) = parser("[test](https://www.github.com)");
var [_, text, _, url, _] = value;
```
