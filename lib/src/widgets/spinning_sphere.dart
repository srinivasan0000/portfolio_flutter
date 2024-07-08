import 'package:flutter/material.dart';
import 'dart:math';

class SpinningSphere extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Duration duration;
  final double size;

  const SpinningSphere({
    super.key,
    required this.color1,
    required this.color2,
    this.duration = const Duration(seconds: 5),
    this.size = 200,
  });

  @override
  State<SpinningSphere> createState() => _SpinningSphereState();
}

class _SpinningSphereState extends State<SpinningSphere> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: TwoColorSpherePainter(
            rotation: _controller.value,
            color1: widget.color1,
            color2: widget.color2,
          ),
          size: Size(widget.size, widget.size),
        );
      },
    );
  }
}

class TwoColorSpherePainter extends CustomPainter {
  final double rotation;
  final Color color1;
  final Color color2;

  TwoColorSpherePainter({
    required this.rotation,
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width / 2, size.height / 2);
    final center = Offset(size.width / 2, size.height / 2);
    final angle = rotation * 2 * pi;

    // Background of the sphere with two colors
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color1, color2],
        stops: const [0.5, 1.0],
        center: Alignment(cos(angle), sin(angle)),
        radius: 1.0,
      ).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ));

    // Draw the solid sphere
    canvas.drawCircle(center, radius, paint);

    // Create a light reflection
    final reflectionPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withOpacity(0.4), Colors.transparent],
        stops: const [0.0, 1.0],
        center: Alignment(cos(angle + pi / 3), sin(angle + pi / 3)),
        radius: 0.3,
      ).createShader(Rect.fromCircle(
        center: Offset(
          center.dx + cos(angle + pi / 3) * radius / 2,
          center.dy + sin(angle + pi / 3) * radius / 2,
        ),
        radius: radius / 4,
      ));
    canvas.drawCircle(
      Offset(
        center.dx + cos(angle + pi / 3) * radius / 2,
        center.dy + sin(angle + pi / 3) * radius / 2,
      ),
      radius / 4,
      reflectionPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
