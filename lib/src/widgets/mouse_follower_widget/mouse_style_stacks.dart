// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/extensions/material_extensions.dart';
import 'dart:math';
import 'mouse_style_widget.dart';

enum AppMouseStyleStack {
  mouseStylesStack1,
  mouseStylesStack2,
  mouseStylesStack3,
  mouseStylesStack4,
  mouseStylesStack5,
}

List<MouseStyle> getMouseStyleStack(AppMouseStyleStack appMouseStyleStack, BuildContext context) {
  switch (appMouseStyleStack) {
    case AppMouseStyleStack.mouseStylesStack1:
      return [
        MouseStyle(
          opaque: true,
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 25),
          decoration: BoxDecoration(color: context.colorTheme.tertiary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 100),
          decoration: BoxDecoration(color: context.colorTheme.primary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 150),
          decoration: BoxDecoration(color: context.colorTheme.secondary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 300),
          decoration: BoxDecoration(color: context.colorTheme.primary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 500),
          decoration: BoxDecoration(color: context.colorTheme.primary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(color: context.colorTheme.inverseSurface, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(7, 7),
          latency: const Duration(milliseconds: 1200),
          decoration: BoxDecoration(color: context.colorTheme.primary, shape: BoxShape.circle),
          child: const Card(
            shape: CircleBorder(),
          ),
        ),
      ];

    case AppMouseStyleStack.mouseStylesStack2:
      return [
        MouseStyle(
          visibleOnHover: false,
          size: const Size(15, 15),
          latency: const Duration(milliseconds: 25),
          decoration: BoxDecoration(
            color: context.colorTheme.primary,
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorTheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        MouseStyle(
          size: const Size(25, 25),
          latency: const Duration(milliseconds: 75),
          visibleOnHover: true,
          decoration: BoxDecoration(
            color: context.colorTheme.primary.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
        MouseStyle(
          size: const Size(30, 30),
          latency: const Duration(milliseconds: 105),
          animationDuration: Durations.extralong1,
          visibleOnHover: true,
          decoration: BoxDecoration(
            color: context.colorTheme.primary,
            shape: BoxShape.circle,
          ),
        ),
      ];

    case AppMouseStyleStack.mouseStylesStack3:
      return [
        MouseStyle(
          opaque: true,
          visibleOnHover: false,
          size: const Size(8, 8),
          latency: const Duration(milliseconds: 10),
          decoration: BoxDecoration(
            color: context.colorTheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(30, 30),
          latency: const Duration(milliseconds: 50),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colorTheme.primary,
              width: 2,
            ),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(40, 40),
          latency: const Duration(milliseconds: 100),
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 500),
            turns: 1,
            child: Stack(
              children: List.generate(8, (index) {
                return Positioned(
                  left: 20 * cos(index * pi / 4),
                  top: 20 * sin(index * pi / 4),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ];

    case AppMouseStyleStack.mouseStylesStack4:
      return [
        MouseStyle(
          opaque: true,
          visibleOnHover: false,
          size: const Size(20, 20),
          latency: const Duration(milliseconds: 10),
          child: AnimatedRotation(
            duration: const Duration(seconds: 2),
            turns: 1,
            child: CustomPaint(
              painter: TrianglePainter(color: Theme.of(context).primaryColor),
              size: const Size(20, 20),
            ),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(100, 100),
          latency: const Duration(milliseconds: 50),
          child: SpiralTrail(
            color: context.colorTheme.primary,
            spiralCount: 3,
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(60, 60),
          latency: const Duration(milliseconds: 100),
          child: PulsingHexagon(
            color: context.colorTheme.primary.withOpacity(0.5),
            pulseDuration: const Duration(seconds: 1),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(120, 120),
          latency: const Duration(milliseconds: 150),
          child: Stack(
            children: [
              OrbitingWidget(
                color: context.colorTheme.primary,
                radius: 40,
                duration: const Duration(seconds: 5),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: context.colorTheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              OrbitingWidget(
                color: context.colorTheme.primary,
                radius: 30,
                duration: const Duration(seconds: 3),
                child: Icon(
                  Icons.star,
                  size: 15,
                  color: context.colorTheme.primary,
                ),
              ),
              OrbitingWidget(
                color: context.colorTheme.primary,
                radius: 50,
                duration: const Duration(seconds: 7),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ];

    case AppMouseStyleStack.mouseStylesStack5:
      return [
        MouseStyle(
          opaque: true,
          visibleOnHover: false,
          size: const Size(15, 15),
          latency: const Duration(milliseconds: 10),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.colorTheme.primary,
                  context.colorTheme.primary.withOpacity(0.5),
                ],
              ),
            ),
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(100, 100),
          latency: const Duration(milliseconds: 50),
          child: RippleEffect(
            color: context.colorTheme.primary.withOpacity(0.3),
            rippleCount: 3,
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(80, 80),
          latency: const Duration(milliseconds: 100),
          child: RotatingShapes(
            shapes: 5,
            color: context.colorTheme.primary,
          ),
        ),
        MouseStyle(
          visibleOnHover: true,
          size: const Size(120, 120),
          latency: const Duration(milliseconds: 0),
          child: ParticleBurst(
            color: context.colorTheme.secondary,
            particleCount: 50,
          ),
        ),
      ];
  }
}

class ParticleBurst extends StatefulWidget {
  final Color color;
  final int particleCount;

  const ParticleBurst({super.key, required this.color, required this.particleCount});

  @override
  State<ParticleBurst> createState() => _ParticleBurstState();
}

class _ParticleBurstState extends State<ParticleBurst> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle1> particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    particles = List.generate(widget.particleCount, (_) => Particle1());
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticleBurstPainter(
            particles: particles,
            color: widget.color,
            progress: _controller.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle1 {
  late double speed;
  late double theta;
  late double radius;

  Particle1() {
    restart();
  }

  void restart() {
    speed = Random().nextDouble() * 0.5 + 0.5;
    theta = Random().nextDouble() * 2 * pi;
    radius = 0;
  }
}

class ParticleBurstPainter extends CustomPainter {
  final List<Particle1> particles;
  final Color color;
  final double progress;

  ParticleBurstPainter({required this.particles, required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    for (var particle in particles) {
      particle.radius = particle.speed * progress * size.width / 2;
      final x = center.dx + particle.radius * cos(particle.theta);
      final y = center.dy + particle.radius * sin(particle.theta);

      final opacity = (1 - progress) * 0.8;
      paint.color = color.withOpacity(opacity);

      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(ParticleBurstPainter oldDelegate) => true;
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}

class SpiralTrail extends StatefulWidget {
  final Color color;
  final int spiralCount;

  const SpiralTrail({super.key, required this.color, required this.spiralCount});

  @override
  State<SpiralTrail> createState() => _SpiralTrailState();
}

class _SpiralTrailState extends State<SpiralTrail> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SpiralPainter(
            color: widget.color,
            progress: _controller.value,
            spiralCount: widget.spiralCount,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SpiralPainter extends CustomPainter {
  final Color color;
  final double progress;
  final int spiralCount;

  SpiralPainter({required this.color, required this.progress, required this.spiralCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < spiralCount; i++) {
      final path = Path();
      for (double t = 0; t <= progress * 2 * pi; t += 0.1) {
        final r = t / (2 * pi) * radius;
        final x = center.dx + r * cos(t + 2 * pi * i / spiralCount);
        final y = center.dy + r * sin(t + 2 * pi * i / spiralCount);
        if (t == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(SpiralPainter oldDelegate) => true;
}

class PulsingHexagon extends StatefulWidget {
  final Color color;
  final Duration pulseDuration;

  const PulsingHexagon({super.key, required this.color, required this.pulseDuration});

  @override
  State<PulsingHexagon> createState() => _PulsingHexagonState();
}

class _PulsingHexagonState extends State<PulsingHexagon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.pulseDuration);
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: HexagonPainter(color: widget.color, scale: _animation.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  final double scale;

  HexagonPainter({required this.color, required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * scale;

    for (int i = 0; i < 6; i++) {
      final angle = i * 60 * pi / 180;
      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) => true;
}

class OrbitingWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  final double radius;
  final Duration duration;

  const OrbitingWidget({
    super.key,
    required this.child,
    required this.color,
    required this.radius,
    required this.duration,
  });

  @override
  State<OrbitingWidget> createState() => _OrbitingWidgetState();
}

class _OrbitingWidgetState extends State<OrbitingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * pi;
        return Transform.translate(
          offset: Offset(
            widget.radius * cos(angle),
            widget.radius * sin(angle),
          ),
          child: Transform.rotate(
            angle: angle,
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RippleEffect extends StatefulWidget {
  final Color color;
  final int rippleCount;

  const RippleEffect({super.key, required this.color, required this.rippleCount});

  @override
  State<RippleEffect> createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RipplePainter(
            color: widget.color,
            progress: _controller.value,
            rippleCount: widget.rippleCount,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RipplePainter extends CustomPainter {
  final Color color;
  final double progress;
  final int rippleCount;

  RipplePainter({required this.color, required this.progress, required this.rippleCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (int i = 0; i < rippleCount; i++) {
      final rippleProgress = (progress + i / rippleCount) % 1.0;
      final radius = maxRadius * rippleProgress;
      canvas.drawCircle(center, radius, paint..color = color.withOpacity(1 - rippleProgress));
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) => true;
}

class RotatingShapes extends StatefulWidget {
  final int shapes;
  final Color color;

  const RotatingShapes({super.key, required this.shapes, required this.color});

  @override
  State<RotatingShapes> createState() => _RotatingShapesState();
}

class _RotatingShapesState extends State<RotatingShapes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RotatingShapesPainter(
            shapes: widget.shapes,
            color: widget.color,
            progress: _controller.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RotatingShapesPainter extends CustomPainter {
  final int shapes;
  final Color color;
  final double progress;

  RotatingShapesPainter({required this.shapes, required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    for (int i = 0; i < shapes; i++) {
      final angle = 2 * pi * (i / shapes + progress);
      final shapeCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.save();
      canvas.translate(shapeCenter.dx, shapeCenter.dy);
      canvas.rotate(angle * 2);

      switch (i % 4) {
        case 0:
          canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 20, height: 20), paint);
          break;
        case 1:
          canvas.drawCircle(Offset.zero, 10, paint);
          break;
        case 2:
          final path = Path()
            ..moveTo(0, -10)
            ..lineTo(-8.66, 5)
            ..lineTo(8.66, 5)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case 3:
          final path = Path();
          for (int j = 0; j < 5; j++) {
            final angle = 2 * pi * j / 5 - pi / 2;
            final point = Offset(10 * cos(angle), 10 * sin(angle));
            j == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
          }
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(RotatingShapesPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.shapes != shapes || oldDelegate.color != color;
}

// List<MouseStyle> getMouseStyleStack(AppMouseStyleStack appMouseStyleStack, BuildContext context) {
//   switch (appMouseStyleStack) {
//     case AppMouseStyleStack.mouseStylesStack1:
//       return [
//         const MouseStyle(
//           opaque: true,
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 25),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: const Card(
//             shape: CircleBorder(),
//           ),
//         ),
//         const MouseStyle(
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 100),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: Card(
//             shape: CircleBorder(),
//           ),
//         ),
//         const MouseStyle(
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 150),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: Card(
//             shape: CircleBorder(),
//           ),
//         ),
//         const MouseStyle(
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 300),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: Card(
//             shape: CircleBorder(),
//           ),
//         ),
//         const MouseStyle(
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 500),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: Card(
//             shape: CircleBorder(),
//           ),
//         ),
//         const MouseStyle(
//           visibleOnHover: true,
//           size: Size(7, 7),
//           latency: Duration(milliseconds: 1000),
//           decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//           child: Card(
//             shape: CircleBorder(),
//           ),
//         ),
//       ];

//     case AppMouseStyleStack.mouseStylesStack2:
//       return [
//         // Base layer with a ripple effect on hover
//         MouseStyle(
//           visibleOnHover: false,
//           size: const Size(15, 15), // Adjust size as needed
//           latency: const Duration(milliseconds: 25),
//           decoration: const BoxDecoration(
//             color: Colors.transparent,
//             shape: BoxShape.circle,
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),

//         // Middle layer with a growing circle on hover
//         MouseStyle(
//           size: const Size(25, 25),
//           latency: const Duration(milliseconds: 75),
//           visibleOnHover: true,
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor.withOpacity(0.4),
//             shape: BoxShape.circle,
//           ),
//         ),

//         // Top layer with a solid circle on hover
//         MouseStyle(
//           size: const Size(30, 30), // Adjust size as needed
//           latency: const Duration(milliseconds: 105),
//           animationDuration: Durations.extralong1,
//           visibleOnHover: true,
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ];

//     case AppMouseStyleStack.mouseStylesStack3:
//       return [];
//   }
// }

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 4, size.height * 3 / 4, size.width / 2, size.height / 2);
    path.quadraticBezierTo(size.width * 3 / 4, size.height / 4, size.width, size.height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MouseStackStyleNotifier extends Notifier<AppMouseStyleStack> {
  @override
  build() {
    return AppMouseStyleStack.mouseStylesStack1;
  }

  void changeMouseStyleStack(AppMouseStyleStack appMouseStyleStack) {
    state = appMouseStyleStack;
  }
}

final appMouseStackStyleProvider =
    NotifierProvider<MouseStackStyleNotifier, AppMouseStyleStack>(MouseStackStyleNotifier.new);

class ParticleAnimationWidget extends StatefulWidget {
  final Widget child;
  final int particleCount;
  final Color particleColor;
  final double particleSize;
  final Duration duration;
  final double spreadRadius;

  const ParticleAnimationWidget({
    super.key,
    required this.child,
    this.particleCount = 50,
    this.particleColor = Colors.white,
    this.particleSize = 2.0,
    this.duration = const Duration(seconds: 2),
    this.spreadRadius = 50.0,
  });

  @override
  State<ParticleAnimationWidget> createState() => _ParticleAnimationWidgetState();
}

class _ParticleAnimationWidgetState extends State<ParticleAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
    _particles = List.generate(widget.particleCount, (_) => Particle(widget.particleSize));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none, // Ensure particles can go outside the bounds
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: ParticlePainter(
              particles: _particles,
              progress: _controller.value,
              color: widget.particleColor,
              spreadRadius: widget.spreadRadius,
            ),
          ),
        ),
      ],
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double life;
  final double maxSize;

  Particle(this.maxSize)
      : position = Offset.zero,
        velocity = Offset.zero,
        life = 1.0 {
    reset();
  }

  void reset() {
    final random = Random();
    position = Offset.zero; // Start from the center
    final angle = random.nextDouble() * 2 * pi;
    final speed = random.nextDouble() * 2 + 0.5;
    velocity = Offset(cos(angle) * speed, sin(angle) * speed);
    life = 1.0;
  }

  void update(double delta) {
    position += velocity * delta;
    life -= delta * 0.2;
    if (life < 0) reset();
  }

  double get size => maxSize * (life > 0.5 ? 1 : life * 2);
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;
  final Color color;
  final double spreadRadius; // Added to control the spread radius

  ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
    required this.spreadRadius,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()..color = color;
    for (final particle in particles) {
      particle.update(progress);
      final particleSize = particle.size;
      canvas.drawCircle(
        Offset(
          canvasSize.width / 2 + particle.position.dx * spreadRadius,
          canvasSize.height / 2 + particle.position.dy * spreadRadius,
        ),
        particleSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
