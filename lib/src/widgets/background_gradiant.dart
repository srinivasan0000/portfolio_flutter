import 'dart:math' as math;

import 'package:flutter/material.dart';

class BackgroundGradientAnimation extends StatefulWidget {
  const BackgroundGradientAnimation({super.key, required this.child});
  final Widget child;
  @override
  State<BackgroundGradientAnimation> createState() => _BackgroundGradientAnimationState();
}

class _BackgroundGradientAnimationState extends State<BackgroundGradientAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Color> colors = [
    const Color(0xFF8B5CF6).withOpacity(0.3),
    const Color(0xFF3B82F6).withOpacity(0.3),
    const Color(0xFF2DD4BF).withOpacity(0.3),
    const Color(0xFF4ADE80).withOpacity(0.3),
  ];
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateMousePosition(PointerEvent details) {
    setState(() {
      _mousePosition = details.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updateMousePosition,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: BackgroundPainter(
              animation: _controller,
              colors: colors,
              mousePosition: _mousePosition,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final List<Color> colors;
  final Offset mousePosition;

  BackgroundPainter({
    required this.animation,
    required this.colors,
    required this.mousePosition,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    for (int i = 0; i < colors.length; i++) {
      final offset = animation.value * 2 * math.pi / colors.length * i;
      final x = mousePosition.dx + math.cos(offset) * size.width / 4;
      final y = mousePosition.dy + math.sin(offset) * size.height / 4;
      final gradient = RadialGradient(
        center: Alignment(
          (x / size.width * 2) - 1,
          (y / size.height * 2) - 1,
        ),
        colors: [colors[i].withOpacity(0.5), colors[i].withOpacity(0)],
        radius: 1,
      );
      paint.shader = gradient.createShader(rect);
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.mousePosition != mousePosition;
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
