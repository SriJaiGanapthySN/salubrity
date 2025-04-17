import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with animation
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withOpacity(0.8),
                      colorScheme.primary.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.white, size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Welcome to Salubrity',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Our mission is to make mental health support accessible to everyone. We believe in a world where mental wellness is prioritized and stigma-free.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Features section
            buildFeatureCard(
              context,
              icon: Icons.psychology,
              title: 'Guided Mindfulness',
              description:
                  'Access expert-led meditation and mindfulness exercises to reduce stress and anxiety.',
            ),

            buildFeatureCard(
              context,
              icon: Icons.track_changes,
              title: 'Mood Tracking',
              description:
                  'Monitor your emotional wellbeing with our intuitive mood tracking tools and analytics.',
              delay: 300,
            ),

            buildFeatureCard(
              context,
              icon: Icons.people_alt,
              title: 'Supportive Community',
              description:
                  'Connect with others on similar journeys in our safe, moderated community spaces.',
              delay: 600,
            ),

            // Mental Health Info section
            const SizedBox(height: 32),
            Text(
              'Why Mental Health Matters',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),

            buildInfoCard(
              context,
              title: 'Global Impact',
              description:
                  'Nearly 1 billion people worldwide live with a mental disorder, with depression being the leading cause of disability globally.',
              icon: Icons.public,
              delay: 300,
            ),

            buildInfoCard(
              context,
              title: 'Early Intervention',
              description:
                  'Research shows that early intervention can significantly improve treatment outcomes and quality of life for those with mental health conditions.',
              icon: Icons.access_time,
              delay: 450,
            ),

            buildInfoCard(
              context,
              title: 'Digital Solutions',
              description:
                  'Mental health apps can bridge treatment gaps by providing support between clinical visits and reaching underserved populations.',
              icon: Icons.smartphone,
              delay: 600,
            ),

            const SizedBox(height: 32),
            // Contact section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.email, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    'Contact us: support@salubrity.com',
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    int delay = 0,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    int delay = 0,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondary.withOpacity(0.2),
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
