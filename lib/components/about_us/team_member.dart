import 'package:flutter/material.dart';

class TeamMember extends StatelessWidget {
  final String name;
  final String role;
  final IconData icon;

  const TeamMember({
    super.key,
    required this.name,
    required this.role,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
