import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'media_card.dart';

class MediaResources extends StatelessWidget {
  const MediaResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        CarouselSlider(
          options: CarouselOptions(
            height: 260,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            viewportFraction: 0.7,
            enlargeFactor: 0.2,
            padEnds: true,
          ),
          items: [
            MediaCard(
              title: 'Subliminal Music',
              description: 'Music that stimulates brain activity and focus',
              icon: Icons.psychology,
              startColor: Colors.purple.shade900,
              endColor: Colors.purple.shade600,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening Subliminal Music content...'),
                  ),
                );
              },
            ),
            MediaCard(
              title: 'Motivational Videos',
              description: 'Enhance motivation and productivity',
              icon: Icons.play_circle_fill,
              startColor: Colors.purple.shade800,
              endColor: Colors.purple.shade400,
            ),
            MediaCard(
              title: 'Binaural Beats',
              description: 'Synchronize brain hemispheres for deep relaxation',
              icon: Icons.surround_sound,
              startColor: Colors.purple.shade600,
              endColor: Colors.purple.shade200,
            ),
            MediaCard(
              title: 'E-Books',
              description: 'Read and learn about mental health and wellness',
              icon: Icons.book,
              startColor: Colors.purple.shade700,
              endColor: Colors.purple.shade300,
            ),
          ],
        ),
      ],
    );
  }
}
