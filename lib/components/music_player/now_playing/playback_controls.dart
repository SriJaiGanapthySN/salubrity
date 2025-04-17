import 'package:flutter/material.dart';

class PlaybackControls extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final AnimationController playPauseController;
  final Color primaryColor;
  final Color secondaryColor;

  const PlaybackControls({
    super.key,
    required this.onPrevious,
    required this.onPlayPause,
    required this.onNext,
    required this.playPauseController,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous button with effects
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPrevious,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.skip_previous_rounded,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Play/Pause button with animation
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onPlayPause,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: playPauseController,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Next button with effects
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onNext,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.skip_next_rounded,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
