import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color startColor;
  final Color endColor;
  final VoidCallback? onTap;

  const MediaCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.startColor,
    required this.endColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:
              onTap ??
              () {
                // Default action if no onTap provided
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening $title content...')),
                );
              },
          child: Stack(
            children: [
              // Decorative pattern overlay
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Opacity(
                    opacity: 0.07,
                    child: CustomPaint(painter: PatternPainter()),
                  ),
                ),
              ),
              // Main content with LayoutBuilder for responsive sizing
              LayoutBuilder(
                builder: (context, constraints) {
                  // Scale down content for side cards
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon container with constrained size
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxWidth * 0.3,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(icon, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        // Title with constrained width
                        SizedBox(
                          width: constraints.maxWidth,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        // Description with constrained width and flexible height
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.2,
                          child: Text(
                            description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pattern painter class for the background design
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final spacing = 20.0;

    for (double i = 0; i < size.width + size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(i, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
