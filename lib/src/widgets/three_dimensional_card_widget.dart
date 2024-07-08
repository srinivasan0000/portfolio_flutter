import 'dart:math' as math;
import 'package:flutter/material.dart';

class ThreeDimensionalCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Duration rotationDuration;
  final List<Color> gradientColors;
  final double borderRadius;
  final double sensitivity;
  final Color cardColor;
  final double cardPadding;

  const ThreeDimensionalCard({
    super.key,
    required this.child,
    this.width = 256.0,
    this.height = 256.0,
    this.rotationDuration = const Duration(seconds: 5),
    this.gradientColors = const [
      Colors.cyanAccent,
      Colors.pinkAccent,
      Colors.yellowAccent,
      Colors.cyanAccent,
    ],
    this.borderRadius = 30.0,
    this.sensitivity = 0.01,
    this.cardColor = Colors.white,
    this.cardPadding = 10.0,
  });

  @override
  State<ThreeDimensionalCard> createState() => _ThreeDimensionalCardState();
}

class _ThreeDimensionalCardState extends State<ThreeDimensionalCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final ValueNotifier<Offset> _location = ValueNotifier<Offset>(Offset.zero);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: widget.gradientColors,
                    transform: GradientRotation(_controller.value * 2 * math.pi),
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              );
            },
          ),
          ValueListenableBuilder<Offset>(
            valueListenable: _location,
            builder: (context, location, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateX(widget.sensitivity * location.dy)
                  ..rotateY(-widget.sensitivity * location.dx),
                alignment: FractionalOffset.center,
                child: child,
              );
            },
            child: GestureDetector(
              onPanUpdate: (details) {
                _location.value += details.delta;
              },
              onPanEnd: (details) {
                _location.value = Offset.zero;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Container(
                  width: widget.width - widget.cardPadding,
                  height: widget.height - widget.cardPadding,
                  color: widget.cardColor,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
