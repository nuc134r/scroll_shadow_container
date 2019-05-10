# scroll_shadow_container

[![pub package](https://img.shields.io/pub/v/scroll_shadow_container.svg)](https://pub.dartlang.org/packages/scroll_shadow_container)

A widget that wraps scrollable container and draws neat little shadows until top or bottom of container is not reached.

![shadows](https://user-images.githubusercontent.com/13202642/57546017-8cf06780-7364-11e9-8dc5-78a55c8d24f7.gif)

## Usage
To use this [package](https://pub.dartlang.org/packages/scroll_shadow_container), add `scroll_shadow_container` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
```
dependencies:
  scroll_shadow_container:
```
And import the package in your code.
``` dart
import 'package:scroll_shadow_container/scroll_shadow_container.dart';
```

## Example

You can specify shadow elevation via `elevation` property which does not very accurately mocks `Material`'s elevation.

```dart
ScrollShadowContainer(
  elevation: MaterialElevation.the2dp,
  child: ListView(
    children: List.generate(10, (i) {
      return ListTile(
        leading: CircleAvatar(child: Text((i + 1).toString())),
        title: Text('List item title'),
        subtitle: Text('List item subtitle'),
      );
    }),
  ),
)
```
Or you can use `ScrollShadowContainer.custom` constructor to supply your own `BoxShadow`:

```dart
ScrollShadowContainer.custom(
  boxShadow: BoxShadow(blurRadius: 5, spreadRadius: 5),
  child: /* ... */
)
```
