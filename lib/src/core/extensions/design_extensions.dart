import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'material_extensions.dart';

extension ThreeDimensionalCardExtension on Widget {
  Widget withThreeDimensionalCard({
    double padding = 7.0,
    double borderRadius = 20.0,
    Duration animationDuration = const Duration(seconds: 5),
    Color cardColor = Colors.black,
    List<Color> gradientColors = const [
      Colors.cyanAccent,
      Colors.pinkAccent,
      Colors.yellowAccent,
      Colors.cyanAccent,
    ],
  }) {
    return _ThreeDimensionalCard(
      padding: padding,
      borderRadius: borderRadius,
      animationDuration: animationDuration,
      cardColor: cardColor,
      gradientColors: gradientColors,
      child: this,
    );
  }

  Widget withGradiant() {
    return WithGradiant(child: this);
  }
}

class _ThreeDimensionalCard extends StatefulWidget {
  final Widget child;
  final double padding;
  final double borderRadius;
  final Duration animationDuration;
  final Color cardColor;
  final List<Color> gradientColors;

  const _ThreeDimensionalCard({
    required this.child,
    this.padding = 7.0,
    this.borderRadius = 20.0,
    this.animationDuration = const Duration(seconds: 5),
    this.cardColor = Colors.black,
    this.gradientColors = const [
      Colors.cyanAccent,
      Colors.pinkAccent,
      Colors.yellowAccent,
      Colors.cyanAccent,
    ],
  });

  @override
  State<_ThreeDimensionalCard> createState() => _ThreeDimensionalCardState();
}

class _ThreeDimensionalCardState extends State<_ThreeDimensionalCard> with SingleTickerProviderStateMixin {
  Offset location = Offset.zero;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )
      ..repeat()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final childWidth = width - 2 * widget.padding;
        final childHeight = height - 2 * widget.padding;

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: widget.gradientColors,
                    transform: _animatedGradientTransform(),
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002) 
                  ..rotateX(0.001 * location.dy)
                  ..rotateY(-0.001 * location.dx),
                alignment: FractionalOffset.center,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    location += details.delta;
                    setState(() {});
                  },
                  onPanEnd: (details) {
                    location = Offset.zero;
                    setState(() {});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Container(
                      width: childWidth,
                      height: childHeight,
                      color: widget.cardColor,
                      child: Padding(
                        padding: EdgeInsets.all(widget.padding),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  GradientRotation _animatedGradientTransform() {
    return GradientRotation(_controller.value * 2 * math.pi);
  }
}

class WithGradiant extends StatelessWidget {
  const WithGradiant({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              // Colors.red,
              // context.colorTheme.errorContainer,
              context.colorTheme.tertiary,
              context.colorTheme.tertiaryContainer,
              context.colorTheme.tertiaryContainer,
              context.colorTheme.tertiary,
              // context.colorTheme.tertiaryContainer,
              context.colorTheme.primaryContainer, // Colors.blue,
              // Colors.green,
              context.colorTheme.tertiaryContainer,
              context.colorTheme.tertiary,
              // context.colorTheme.primaryContainer,
              // context.colorTheme.tertiary,
              // context.colorTheme.error,
              // context.colorTheme.errorContainer,
            ],
          ).createShader(bounds);
        },
        child: child);
  }
}
