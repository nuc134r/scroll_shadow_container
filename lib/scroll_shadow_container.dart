library scroll_shadow_container;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Material Design elevation values
enum MaterialElevation {
  the1dp,
  the2dp,
  the3dp,
  the4dp,
  the5dp,
  the6dp,
  the7dp,
  the8dp,
}

/// Not very accurate [Material]'s elevation value to [BoxShadow] converter which
/// wraps it into [BoxDecoration] for use with [Container.decoration].
///
/// Values from 1 to 8 were calculated through trials and side by side comparison.
class MaterialShadow {
  static BoxDecoration asBoxDecoration({MaterialElevation elevation}) {
    BoxShadow shadow;

    switch (elevation) {
      case MaterialElevation.the1dp:
        shadow = BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 0);
        break;
      case MaterialElevation.the2dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 1, blurRadius: 1);
        break;
      case MaterialElevation.the3dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 2);
        break;
      case MaterialElevation.the4dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5);
        break;
      case MaterialElevation.the5dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 3, blurRadius: 5);
        break;
      case MaterialElevation.the6dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 4, blurRadius: 6);
        break;
      case MaterialElevation.the7dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 4, blurRadius: 7);
        break;
      case MaterialElevation.the8dp:
        shadow = BoxShadow(color: Colors.black26, spreadRadius: 5, blurRadius: 8);
        break;
      default:
    }

    return BoxDecoration(boxShadow: [shadow]);
  }
}

/// Wraps scrollable container and draws neat little shadows until top or
/// bottom of container is not reached.
///
/// You can specify shadow elevation via [elevation] property which is
/// not very accurately mocks [Material]'s elevation. Default value is [MaterialElevation.the2dp].
///
/// Or you can use [ScrollShadowContainer.custom] constructor to supply
/// your own [BoxShadow].
///
/// Example:
/// ```dart
/// ScrollShadowContainer(
///   elevation: MaterialElevation.the2dp,
///   child: ListView(
///     children: List.generate(10, (i) {
///       return ListTile(
///         leading: CircleAvatar(child: Text((i + 1).toString())),
///         title: Text('List item title'),
///         subtitle: Text('List item subtitle'),
///       );
///     }),
///   ),
/// )
/// ```
class ScrollShadowContainer extends StatefulWidget {
  const ScrollShadowContainer({
    @required this.child,
    this.elevation = MaterialElevation.the2dp,
  }) : boxShadow = null;

  const ScrollShadowContainer.custom({
    @required this.child,
    @required this.boxShadow,
  }) : elevation = null;

  final Widget child;
  final MaterialElevation elevation;
  final BoxShadow boxShadow;

  @override
  _ScrollShadowContainerState createState() => _ScrollShadowContainerState();
}

class _ScrollShadowContainerState extends State<ScrollShadowContainer> {
  ScrollController _scrollController;

  bool _needShadowOnTop = false;
  bool _needShadowOnBottom = false;

  BoxDecoration get _shadowDecoration =>
      widget.boxShadow != null ? BoxDecoration(boxShadow: [widget.boxShadow]) : MaterialShadow.asBoxDecoration(elevation: widget.elevation);
  BoxDecoration get _emptyDecoration => BoxDecoration();

  void _updateShadowsVisibility() {
    bool top;
    bool bottom;

    if (!_scrollController.hasClients) {
      if (_scrollController.initialScrollOffset > 0) {
        top = true;
        bottom = true;
      } else {
        top = false;
        bottom = true;
      }
    } else if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
        top = false;
      } else {
        top = true;
      }
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        bottom = false;
      } else {
        bottom = true;
      }
    } else {
      top = bottom = true;
    }

    if (_needShadowOnTop != top || _needShadowOnBottom != bottom) {
      _needShadowOnTop = top;
      _needShadowOnBottom = bottom;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateShadowsVisibility());
  }

  @override
  Widget build(BuildContext context) {
    if (_scrollController != PrimaryScrollController.of(context)) {
      _scrollController = PrimaryScrollController.of(context);
      _scrollController.addListener(_updateShadowsVisibility);
    }

    return ClipRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: widget.child,
          ),
          // Shadow on top
          Positioned(
            top: 0,
            child: Container(
              height: 0,
              width: MediaQuery.of(context).size.width,
              decoration: _needShadowOnTop ? _shadowDecoration : _emptyDecoration,
            ),
          ),
          // Shadow on bottom
          Positioned(
            bottom: 0,
            child: Container(
              height: 0,
              width: MediaQuery.of(context).size.width,
              decoration: _needShadowOnBottom ? _shadowDecoration : _emptyDecoration,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateShadowsVisibility);
    super.dispose();
  }
}
