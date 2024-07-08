import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PetalWidget extends ConsumerStatefulWidget {
  const PetalWidget({
    super.key,
    this.size = const Size(300, 300),
    this.layers = const [
      Layer(
        colors: [Colors.orange, Colors.yellow, Colors.green, Colors.cyan, Colors.blue, Colors.purple, Colors.pink, Colors.red],
        petalShape: BoxShape.circle,
        centerSize: 0.5,
        petalSize: 60,
        layerOffset: 0.3,
      ),
      Layer(
        colors: [Colors.deepOrange, Colors.lime, Colors.teal, Colors.indigo, Colors.deepPurple, Colors.pinkAccent, Colors.redAccent, Colors.amber],
        petalShape: BoxShape.circle,
        centerSize: 0.2,
        petalSize: 40,
        layerOffset: 0.15,
      ),
    ],
    this.springDescription = const SpringDescription(mass: 0.8, stiffness: 180.0, damping: 20.0),
    this.animationDuration = const Duration(milliseconds: 250),
    this.shadowBlurRadius = 10.0,
    this.openShadowBlurRadius = 30.0,
    this.rotationDuration = const Duration(seconds: 10),
    this.tiltDuration = const Duration(seconds: 2),
  });

  final List<Layer> layers;
  final SpringDescription springDescription;
  final Duration animationDuration;
  final double shadowBlurRadius;
  final double openShadowBlurRadius;
  final Duration rotationDuration;
  final Duration tiltDuration;
  final Size size;

  @override
  ConsumerState<PetalWidget> createState() => _PetalWidgetState();
}

class Layer {
  const Layer({
    required this.colors,
    required this.petalShape,
    required this.centerSize,
    required this.petalSize,
    required this.layerOffset,
  });

  final List<Color> colors;
  final BoxShape petalShape;
  final double centerSize;
  final double petalSize;
  final double layerOffset;
}

class _PetalWidgetState extends ConsumerState<PetalWidget> with TickerProviderStateMixin {
  bool _isOpen = true;
  Color _selectedColor = Colors.purple;
  late final AnimationController _animationController;
  late final AnimationController _rotationController;
  late final AnimationController _tiltController;
  late final Animation<double> _tiltAnimation;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _openMenu();
  }

  void _initializeControllers() {
    _animationController = AnimationController(vsync: this, duration: widget.animationDuration, upperBound: 1.1)..addStatusListener(_handleAnimationStatus);

    _rotationController = AnimationController(vsync: this, duration: widget.rotationDuration)..repeat();

    _tiltController = AnimationController(vsync: this, duration: widget.tiltDuration)..repeat(reverse: true);

    _tiltAnimation = CurvedAnimation(parent: _tiltController, curve: Curves.easeInOut);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      final simulation = SpringSimulation(widget.springDescription, _animationController.value, 0.05, _animationController.velocity);
      _animationController.animateWith(simulation);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    _tiltController.dispose();
    super.dispose();
  }

  void _openMenu() {
    _animationController.reset();
    final simulation = SpringSimulation(widget.springDescription, 0, 1, _animationController.velocity);
    _animationController.animateWith(simulation);
    setState(() => _isOpen = true);
  }

  void _closeMenu(Color color) {
    _animationController.reverse();
    setState(() => _selectedColor = color);
    Future.delayed(widget.animationDuration, () {
      setState(() {
        _animationController.reset();
        _isOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabBarAnimate = ref.watch(tabBarAnimateProvider);
    return AnimatedBuilder(
      animation: Listenable.merge([_animationController, _rotationController, _tiltAnimation]),
      builder: (context, child) => Center(
        child: Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ..._buildPetals(tabBarAnimate),
              if (!_isOpen) _buildCenterButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPetals(int tabBarAnimate) {
    return widget.layers.expand((layer) {
      return layer.colors.asMap().entries.map((e) {
        final angle = e.key * (360 / layer.colors.length);
        return _buildPetal(layer, e.value, angle, tabBarAnimate);
      });
    }).toList();
  }

  Widget _buildPetal(Layer layer, Color color, double angle, int tabBarAnimate) {
    return GestureDetector(
      onTap: () {
        _closeMenu(color);
        Future.delayed(const Duration(milliseconds: 800), _openMenu);
      },
      child: Transform.rotate(
        angle: _animationController.drive(Tween(begin: 0.0, end: angle.radians)).value,
        child: Transform.translate(
          offset: Offset(0.0, _animationController.drive(Tween(begin: 0.0, end: -widget.size.width * layer.layerOffset)).value),
          child: Transform(
            transform: Matrix4.identity()..rotateZ(_tiltAnimation.value * (tabBarAnimate == 1 ? 0.5 : 0.0)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: tabBarAnimate == 2 ? (Matrix4.identity()..rotateX(_tiltAnimation.value)) : Matrix4.identity(),
              height: _animationController.drive(Tween(begin: layer.petalSize, end: layer.petalSize * 1.5)).value,
              width: layer.petalSize,
              margin: const EdgeInsets.all(100),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [color, color, color.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _animationController.drive(ColorTween(begin: Colors.transparent, end: Colors.black.withOpacity(0.4))).value!,
                    blurRadius: 5,
                    offset: const Offset(0, 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: _openMenu,
      child: Container(
        width: widget.size.width * widget.layers.first.centerSize,
        height: widget.size.width * widget.layers.first.centerSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedColor,
        ),
      ),
    );
  }
}

extension NumX<T extends num> on T {
  double get radians => (this * math.pi) / 180.0;
  double get stepsInAngle => (math.pi * 2) / this;
}

Offset toPolar(Offset center, int index, int total, double radius) {
  final theta = index * total.stepsInAngle;
  final dx = radius * math.cos(theta);
  final dy = radius * math.sin(theta);
  return Offset(dx, dy) + center;
}

final tabBarAnimateProvider = StateProvider<int>((ref) => 0);
