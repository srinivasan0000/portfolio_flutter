import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MoveUpOnHover extends StatefulWidget {
  final Widget? child;
  const MoveUpOnHover({super.key, this.child});

  @override
  State<MoveUpOnHover> createState() => _MoveUpOnHoverState();
}

class _MoveUpOnHoverState extends State<MoveUpOnHover> {
  final nonHoverTransform = Matrix4.identity();
  final hoverTransform = Matrix4.identity()..translate(0, -5, 0);

  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered ? hoverTransform : nonHoverTransform,
        child: widget.child,
      ),
    );
  }
}

class ZoomOnHover extends StatefulWidget {
  const ZoomOnHover({
    required this.child,
    this.scale = 1.2,
    super.key,
  });

  final Widget child;
  final double scale;

  @override
  ZoomOnHoverState createState() => ZoomOnHoverState();
}

class ZoomOnHoverState extends State<ZoomOnHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? widget.scale : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: scale,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
        child: Transform.scale(
          scale: scale,
          child: widget.child,
        ),
      ),
    );
  }
}

class ColorShadowOnHover extends StatefulWidget {
  final Widget child;
  final double spreadRadius;
  final double blurRadius;
  final double shadowDistance;
  final double rotationSpeed;
  final List<Color> shadowColors;

  const ColorShadowOnHover({
    super.key,
    required this.child,
    this.spreadRadius = 8.0,
    this.blurRadius = 20.0,
    this.shadowDistance = 10.0,
    this.rotationSpeed = 0.1,
    this.shadowColors = const [Colors.pink, Colors.green, Colors.blue],
  });

  @override
  State<ColorShadowOnHover> createState() => _ColorShadowOnHoverState();
}

class _ColorShadowOnHoverState extends State<ColorShadowOnHover> {
  bool _isHovered = false;
  late Timer _timer;
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      setState(() {
        _angle += widget.rotationSpeed;
        if (_angle >= 2 * pi) _angle = 0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered ? _generateRotatingShadows() : [],
        ),
        child: widget.child,
      ),
    );
  }

  List<BoxShadow> _generateRotatingShadows() {
    int colorCount = widget.shadowColors.length;
    return List.generate(colorCount, (index) {
      double angleOffset = 2 * pi / colorCount * index;
      return BoxShadow(
        spreadRadius: widget.spreadRadius,
        color: widget.shadowColors[index].withOpacity(0.7),
        offset: Offset(
          widget.shadowDistance * cos(_angle + angleOffset),
          widget.shadowDistance * sin(_angle + angleOffset),
        ),
        blurRadius: widget.blurRadius,
      );
    });
  }
}

class MouseShadowOnHover extends StatelessWidget {
  final Widget child;
  final Offset globalMousePosition;
  final bool isMouseInside;

  const MouseShadowOnHover({
    super.key,
    required this.child,
    required this.globalMousePosition,
    required this.isMouseInside,
  });

  @override
  Widget build(BuildContext context) {
    Offset localPosition = const Offset(100, 100);

    if (isMouseInside) {
      RenderBox box = context.findRenderObject() as RenderBox;
      localPosition = box.globalToLocal(globalMousePosition);
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 50),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(
                    (localPosition.dx - 100) / 10,
                    (localPosition.dy - 100) / 10,
                  ),
                  blurRadius: 10,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class FadeShadowTextOnHover extends StatefulWidget {
  final Widget child;
  final String hoverText;

  const FadeShadowTextOnHover({super.key, required this.child, required this.hoverText});

  @override
  State<FadeShadowTextOnHover> createState() => _FadeShadowTextOnHoverState();
}

class _FadeShadowTextOnHoverState extends State<FadeShadowTextOnHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(),
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              widget.child,
              if (_isHovered)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.hoverText,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class FadedTextOnHover extends StatefulWidget {
  const FadedTextOnHover({
    super.key,
    required this.child,
    this.hoverText = 'Hovering on blue container',
    this.fontSize = 12.0,
  });

  final Widget child;
  final String hoverText;
  final double fontSize;

  @override
  State<FadedTextOnHover> createState() => _FadedTextOnHoverState();
}

class _FadedTextOnHoverState extends State<FadedTextOnHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        children: [
          widget.child,
          if (_isHovered)
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _isHovered ? 1.0 : 0.0,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7), Colors.black],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstATop,
                  child: ColoredBox(
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
              ),
            ),
          if (_isHovered)
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.hoverText,
                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: widget.fontSize),
                          speed: const Duration(milliseconds: 5),
                        ),
                        ColorizeAnimatedText(
                          widget.hoverText,
                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          colors: const [Colors.white, Colors.purple, Colors.blue, Colors.yellow, Colors.red],
                          speed: const Duration(milliseconds: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
