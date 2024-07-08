part of 'home_page.dart';

class _GlowingGradientAppBar extends StatefulWidget {
  final Widget child;

  const _GlowingGradientAppBar({required this.child});

  @override
  State<_GlowingGradientAppBar> createState() => _GlowingGradientAppBarState();
}

class _GlowingGradientAppBarState extends State<_GlowingGradientAppBar> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final int blobCount = 4;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      blobCount,
      (index) => AnimationController(
        duration: Duration(seconds: 10 + index * 2),
        vsync: this,
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: _LiquidGlowPainter(_controllers, [
            context.colorTheme.primaryContainer,
            context.colorTheme.secondaryContainer,
            context.colorTheme.tertiaryContainer,
            context.colorTheme.error,
          ]),
          child: Container(),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: Container(
              color: Colors.transparent,
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}

class _LiquidGlowPainter extends CustomPainter {
  final List<AnimationController> controllers;
  final List<Color> colors;

  _LiquidGlowPainter(this.controllers, this.colors) : super(repaint: Listenable.merge(controllers));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < controllers.length; i++) {
      final center = Offset(
        size.width * (0.2 + 0.6 * controllers[i].value),
        (size.height - 10) * (0.2 + 0.6 * math.sin(controllers[i].value * math.pi)),
      );

      final radius = size.height * 0.4;

      paint.shader = RadialGradient(
        colors: [colors[i], Colors.transparent],
        stops: const [0.2, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      final path = Path();
      for (var j = 0; j < 6; j++) {
        final angle = j * math.pi / 3;
        final offset = Offset(
          math.cos(angle) * radius * (0.9 + 0.1 * math.sin(controllers[i].value * math.pi * 2 + j)),
          math.sin(angle) * radius * (0.9 + 0.1 * math.sin(controllers[i].value * math.pi * 2 + j)),
        );
        j == 0 ? path.moveTo(center.dx + offset.dx, center.dy + offset.dy) : path.lineTo(center.dx + offset.dx, center.dy + offset.dy);
      }
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
