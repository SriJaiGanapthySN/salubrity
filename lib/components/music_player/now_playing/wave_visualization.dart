import 'package:flutter/material.dart';
import 'wave_painter.dart';

class WaveVisualization extends StatelessWidget {
  final AnimationController waveController;
  final Color primaryColor;
  final bool isPlaying;

  const WaveVisualization({
    super.key,
    required this.waveController,
    required this.primaryColor,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPlaying) {
      return const SizedBox(height: 12);
    }

    return SizedBox(
      height: 24,
      child: AnimatedBuilder(
        animation: waveController,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(double.infinity, 24),
            painter: WavePainter(
              animation: waveController,
              color: primaryColor.withOpacity(0.2),
            ),
          );
        },
      ),
    );
  }
}
