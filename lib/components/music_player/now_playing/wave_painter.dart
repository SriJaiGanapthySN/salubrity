import 'package:flutter/material.dart';
import 'dart:math' as math;

// Custom painter for audio wave effect
class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  WavePainter({required this.animation, required this.color})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(0, height / 2);

    for (double i = 0; i < width; i++) {
      // Create wave pattern using sine function
      final x = i;
      final y =
          height / 2 +
          math.sin(
                (animation.value * 2 * math.pi) + (i / width) * 4 * math.pi,
              ) *
              (height / 3) *
              math.sin(i / width * math.pi);
      path.lineTo(x, y);
    }

    path.lineTo(width, height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
