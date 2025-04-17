import 'package:flutter/material.dart';

class WellnessActivities extends StatelessWidget {
  const WellnessActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Wellness Activities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        _buildActivityCard(
          context,
          'Meditation',
          'Take 5 minutes to clear your mind and focus on your breathing',
          Icons.spa,
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          context,
          'Gratitude Journal',
          'Write down three things you are grateful for today',
          Icons.edit_note,
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          context,
          'Mood Tracking',
          'Log your mood to identify patterns and triggers',
          Icons.analytics,
        ),
      ],
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.2),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
