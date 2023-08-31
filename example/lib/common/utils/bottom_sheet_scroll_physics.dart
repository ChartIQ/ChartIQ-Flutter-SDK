import 'dart:io';

import 'package:flutter/widgets.dart';

class BottomSheetScrollPhysics extends ScrollPhysics {
  const BottomSheetScrollPhysics({super.parent});

  final ClampingScrollPhysics _clampingScrollPhysics =
      const ClampingScrollPhysics();

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BottomSheetScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (Platform.isAndroid) {
      return _clampingScrollPhysics.applyBoundaryConditions(position, value);
    }
    // Prevents scrolling over the top of the scroll
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      // Underscroll
      return value - position.pixels;
    } else if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      // Hit top edge
      return value - position.minScrollExtent;
    }

    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // It doesn't create a simulation when scrolling over the top of the scroll
    if (Platform.isAndroid) {
      return _clampingScrollPhysics.createBallisticSimulation(
          position, velocity);
    }

    if (position.pixels <= position.minScrollExtent && velocity < 0.0) {
      return null;
    }

    return super.createBallisticSimulation(position, velocity);
  }
}
