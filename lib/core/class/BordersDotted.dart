// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BordersDotted extends CustomPainter {
  final Color? color;
  final double? radius;

  BordersDotted({this.color = const Color(0xffE9D4FF), this.radius = 10});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius!),
        ),
      );

    const dashWidth = 3;
    const dashSpace = 3;

    double distance = 0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
