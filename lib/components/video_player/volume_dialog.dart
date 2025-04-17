import 'package:flutter/material.dart';

class VolumeDialog extends StatelessWidget {
  final double volume;
  final ValueChanged<double> onVolumeChanged;

  const VolumeDialog({
    super.key,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text('Volume', style: TextStyle(color: colorScheme.primary)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            volume <= 0
                ? Icons.volume_off
                : volume < 0.5
                ? Icons.volume_down
                : Icons.volume_up,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: colorScheme.primary,
              thumbColor: colorScheme.primary,
              overlayColor: colorScheme.primary.withOpacity(0.1),
            ),
            child: Slider(
              value: volume,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              label: '${(volume * 100).toInt()}%',
              onChanged: onVolumeChanged,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
          child: Text('Close', style: TextStyle(color: colorScheme.primary)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
