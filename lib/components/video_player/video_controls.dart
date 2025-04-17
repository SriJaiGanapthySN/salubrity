import 'package:flutter/material.dart';

class VideoControls extends StatelessWidget {
  final VoidCallback onPreviousPressed;
  final VoidCallback onVolumePressed;
  final VoidCallback onNextPressed;
  final ColorScheme colorScheme;

  const VideoControls({
    super.key,
    required this.onPreviousPressed,
    required this.onVolumePressed,
    required this.onNextPressed,
    required this.colorScheme,
  });

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(icon, size: 32, color: colorScheme.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.skip_previous, onPreviousPressed),
          _buildControlButton(Icons.volume_up, onVolumePressed),
          _buildControlButton(Icons.skip_next, onNextPressed),
        ],
      ),
    );
  }
}
