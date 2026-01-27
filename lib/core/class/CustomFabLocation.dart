import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final double offsetY; // كم ترفع من الأسفل
  const CustomFabLocation({this.offsetY = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final fabSize = scaffoldGeometry.floatingActionButtonSize;
    final screenSize = scaffoldGeometry.scaffoldSize;

    // يسار
    final dx = 16.0;

    // أسفل مع رفع offsetY
    final dy =
        screenSize.height -
        fabSize.height -
        scaffoldGeometry.minInsets.bottom -
        16.0 -
        offsetY;

    return Offset(dx, dy);
  }
}
