import 'package:flutter/material.dart';
import '../screens/about_us_screen.dart';
import '../screens/our_vision_screen.dart';
import '../screens/our_story_screen.dart';
import '../screens/why_this_app_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Salubrity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Empowering Your Mind Elevate Your Life',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility_outlined),
            title: const Text('Our Vision'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OurVisionScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu_outlined),
            title: const Text('Our Story'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OurStoryScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_mark_outlined),
            title: const Text('Why This App'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WhyThisAppScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
