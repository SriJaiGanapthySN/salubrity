import 'package:flutter/material.dart';

class OurStoryScreen extends StatelessWidget {
  const OurStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Story',
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Story header with animation
                TweenAnimationBuilder<double>(
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
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Decorative element
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.psychology,
                              size: 30,
                              color: colorScheme.primary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.history_edu,
                              size: 32,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Our Story',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                letterSpacing: 0.5,
                                shadows: [
                                  Shadow(
                                    color: colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary.withOpacity(0.05),
                                colorScheme.primary.withOpacity(0.01),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colorScheme.primary.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Founded in 2025, Salubrity began with a simple mission: to make mental health support accessible to everyone. What started as a small initiative has grown into a comprehensive platform that helps thousands of people every day.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        // Path graphic element
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CustomPaint(
                              size: Size(size.width * 0.7, 30),
                              painter: JourneyPathPainter(
                                colorScheme.primary.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Journey section with quote
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
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
                          Icon(Icons.route, color: colorScheme.secondary),
                          const SizedBox(width: 12),
                          Text(
                            'Our Journey',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'The journey of Salubrity began when our founders recognized the gap in accessible mental health resources. Driven by personal experiences and a passion for helping others, they created this platform to ensure everyone has the tools they need for their mental wellbeing.',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: colorScheme.primary,
                              width: 4,
                            ),
                          ),
                          color: colorScheme.primary.withOpacity(0.05),
                        ),
                        child: const Text(
                          '"We believe mental health should be as important as physical health in our society. Our mission is to normalize mental wellness."',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JourneyPathPainter extends CustomPainter {
  final Color color;

  JourneyPathPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, size.height / 2);
    path.quadraticBezierTo(
      3 * size.width / 4,
      size.height,
      size.width,
      size.height / 2,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
