import 'package:flutter/material.dart';
import 'dart:math' as math;

class AlbumArt extends StatelessWidget {
  final bool isPlaying;
  final Color primaryColor;
  final Color secondaryColor;
  final AnimationController waveController;

  const AlbumArt({
    super.key,
    required this.isPlaying,
    required this.primaryColor,
    required this.secondaryColor,
    required this.waveController,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'music_icon',
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Spinning record animation for playing state
            if (isPlaying)
              AnimatedBuilder(
                animation: waveController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: waveController.value * 2 * math.pi,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            const Icon(Icons.music_note, color: Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}
