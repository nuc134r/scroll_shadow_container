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

You can also obtain `BoxDecoration`s used by this package using following code.

```dart
Container(
  decoration: MaterialShadow.asBoxDecoration(elevation: MaterialElevation.the4dp),
)
```

I only tried to replicate Material's shadows so they're not actually identical but close. Only 1 to 8 elevation values available.
