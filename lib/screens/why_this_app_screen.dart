import 'package:flutter/material.dart';

class WhyThisAppScreen extends StatelessWidget {
  const WhyThisAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Why This App'), elevation: 0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary.withOpacity(0.05), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.spa_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Why Salubrity?',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Salubrity is designed to help you improve your mental well-being through the scientifically supported techniques of binaural beats and subliminal audio. Our app provides a convenient and effective way to incorporate these powerful tools into your daily routine.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Binaural Beats Section
              _buildSectionCard(
                context,
                title: 'Binaural Beats',
                icon: Icons.surround_sound,
                children: [
                  _buildSubsectionTitle(context, 'What are Binaural Beats?'),
                  const SizedBox(height: 12),
                  const Text(
                    'Binaural beats are an auditory illusion created when two slightly different frequencies are played separately in each ear. Your brain perceives a third "beat" which is the mathematical difference between these two frequencies. For example, if a 200 Hz tone is played in one ear and a 210 Hz tone in the other, the brain perceives a 10 Hz binaural beat.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  _buildSubsectionTitle(context, 'How Do They Work?'),
                  const SizedBox(height: 12),
                  const Text(
                    'Binaural beats are believed to work through a process called "frequency following response," where your brainwaves synchronize with the frequency of the perceived beat. Different frequency ranges are associated with different mental states:',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  _buildFrequencyItem(
                    context,
                    'Delta (0.5-4 Hz)',
                    'Deep sleep, healing',
                    Colors.indigo,
                  ),
                  _buildFrequencyItem(
                    context,
                    'Theta (4-8 Hz)',
                    'Deep relaxation, meditation, creativity',
                    Colors.blue,
                  ),
                  _buildFrequencyItem(
                    context,
                    'Alpha (8-13 Hz)',
                    'Relaxed alertness, calm focus',
                    Colors.teal,
                  ),
                  _buildFrequencyItem(
                    context,
                    'Beta (13-30 Hz)',
                    'Active thinking, focus, alertness',
                    Colors.amber,
                  ),
                  _buildFrequencyItem(
                    context,
                    'Gamma (30+ Hz)',
                    'Higher mental activity, perception',
                    Colors.deepOrange,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Subliminal Audio Section
              _buildSectionCard(
                context,
                title: 'Subliminal Audio',
                icon: Icons.hearing,
                children: [
                  _buildSubsectionTitle(context, 'What is Subliminal Audio?'),
                  const SizedBox(height: 12),
                  const Text(
                    'Subliminal audio contains positive affirmations and messages recorded at a volume level just below the threshold of conscious hearing. While you may not consciously hear these messages, research suggests they can be processed by your subconscious mind.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  _buildSubsectionTitle(context, 'How Does It Work?'),
                  const SizedBox(height: 12),
                  const Text(
                    'Subliminal audio works by bypassing your conscious mind and delivering positive suggestions directly to your subconscious. Over time, these messages can help reshape negative thought patterns and reinforce positive behaviors and mindsets.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Research Section
              _buildSectionCard(
                context,
                title: 'Research and Evidence',
                icon: Icons.science_outlined,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Scientific research on binaural beats and subliminal audio has shown promising results:',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildResearchItem(
                    context,
                    'A 2019 study published in Psychological Research found that binaural beats in the theta range (6 Hz) enhanced creative thinking.',
                  ),
                  _buildResearchItem(
                    context,
                    'Research in the International Journal of Psychophysiology demonstrated that binaural beats can influence attention and mood states.',
                  ),
                  _buildResearchItem(
                    context,
                    'A 2018 study in the Journal of Alternative and Complementary Medicine found that binaural beat therapy reduced anxiety levels in patients with mild anxiety disorders.',
                  ),
                  _buildResearchItem(
                    context,
                    'Meta-analyses have indicated that subliminal messages can have small but significant effects on behavior and attitudes.',
                  ),
                  _buildResearchItem(
                    context,
                    'A study at University College London found that subliminal audio exposure created neural activations similar to consciously heard messages, suggesting unconscious processing occurs.',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Best Results Section
              _buildSectionCard(
                context,
                title: 'How to Get the Best Results',
                icon: Icons.tips_and_updates_outlined,
                children: [
                  const SizedBox(height: 8),
                  _buildTipItem(
                    context,
                    'Use high-quality headphones for binaural beats to ensure separate frequencies reach each ear',
                  ),
                  _buildTipItem(
                    context,
                    'Practice consistently for at least 15-30 minutes daily',
                  ),
                  _buildTipItem(
                    context,
                    'Find a quiet, comfortable space where you won\'t be disturbed',
                  ),
                  _buildTipItem(
                    context,
                    'Combine with mindfulness or meditation for enhanced effects',
                  ),
                  _buildTipItem(
                    context,
                    'Be patient - benefits often accumulate over time with regular use',
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSubsectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.secondary,
      ),
    );
  }

  Widget _buildFrequencyItem(
    BuildContext context,
    String range,
    String effect,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  TextSpan(
                    text: '$range: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: effect),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResearchItem(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.star, color: theme.colorScheme.secondary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
