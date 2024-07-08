import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/material_extensions.dart';

import '../../../route_management/router.dart';
import '../../../widgets/responsive_widget.dart';

class SimSection extends StatelessWidget {
  const SimSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      desktop: _BuildContainer(height: 300),
      mobile: _BuildContainer(height: 200),
    );
  }
}

class _BuildContainer extends StatefulWidget {
  const _BuildContainer({required this.height});
  final double height;

  @override
  _BuildContainerState createState() => _BuildContainerState();
}

class _BuildContainerState extends State<_BuildContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _splashAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _splashAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => context.goNamed(Routes.boring.name),
        child: MouseRegion(
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Stack(
                  children: [
                    child!,
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CustomPaint(
                          painter: SplashPainter(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            animation: _splashAnimation,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: SizedBox(
              height: widget.height,
              width: double.maxFinite,
              child: Stack(
                children: [
                  _buildBubbleBackground(),
                  _buildBlurOverlay(),
                  _buildContentContainer(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubbleBackground() {
    return SizedBox(
      height: widget.height,
      width: double.maxFinite,
      child: ClipRRect(
        child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: 30,
          colorsOfBubbles: [
            Colors.red,
            Theme.of(context).colorScheme.primary,
            Colors.green,
            Theme.of(context).colorScheme.secondary,
            Colors.blue,
            Theme.of(context).colorScheme.errorContainer,
          ],
          sizeFactor: 0.05,
          opacity: 70,
          speed: BubbleSpeed.slow,
          paintingStyle: PaintingStyle.fill,
          shape: BubbleShape.circle,
        ),
      ),
    );
  }

  Widget _buildBlurOverlay() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform.scale(
      scale: size.width > 800 ? 1.0 : 0.8,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sentiment_very_satisfied,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              size.width > 600 ? const SizedBox(height: 20) : const SizedBox(height: 10),
              Text(
                'Feeling Bored?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              size.width > 600 ? const SizedBox(height: 20) : const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // context.pushNamed(Routes.boring.name);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: context.colorTheme.secondary,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Let\'s Go!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (_isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

class SplashPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;

  SplashPainter({required this.color, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..shader = const LinearGradient(colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow], begin: Alignment.bottomRight, end: Alignment.topLeft)
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width + size.height) / 2 * animation.value;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(SplashPainter oldDelegate) => true;
}
