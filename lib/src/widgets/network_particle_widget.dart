import 'dart:math' as math;
import 'package:flutter/material.dart';

class NetworkParticle extends StatefulWidget {
  const NetworkParticle({
    super.key,
    required this.height,
    required this.width,
    this.lineStrokeWidth = 0.5,
    this.onTapAnimation = true,
    this.numberOfParticles = 400,
    this.speedOfParticles = 2,
    this.awayRadius = 200,
    this.isRandomColor = false,
    this.particleColor = Colors.purple,
    this.awayAnimationDuration = const Duration(milliseconds: 100),
    this.maxParticleSize = 4,
    this.isRandSize = false,
    this.randColorList = const [
      Colors.orange,
      Colors.blue,
      Colors.teal,
      Colors.red,
      Colors.purple,
    ],
    this.awayAnimationCurve = Curves.easeIn,
    this.enableHover = false,
    this.hoverColor = Colors.orangeAccent,
    this.hoverRadius = 80,
    this.connectDots = false,
    required this.lineColor ,
    this.gravity = 0.0,
    this.particleShape = ParticleShape.circle,
    this.attractToMouse = false,
    this.fadeEffect = false,
    this.fadeOpacity = 0.5,
    this.windEffect = const Offset(0, 0),
    this.interactiveColorChange = false,
  });

  final double awayRadius;
  final double height;
  final double width;
  final bool onTapAnimation;
  final double numberOfParticles;
  final double speedOfParticles;
  final bool isRandomColor;
  final Color particleColor;
  final Duration awayAnimationDuration;
  final Curve awayAnimationCurve;
  final double maxParticleSize;
  final bool isRandSize;
  final List<Color> randColorList;
  final bool enableHover;
  final Color hoverColor;
  final double hoverRadius;
  final bool connectDots;
  final Color lineColor;
  final double lineStrokeWidth;
  final double gravity;
  final ParticleShape particleShape;
  final bool attractToMouse;
  final bool fadeEffect;
  final double fadeOpacity;
  final Offset windEffect;
  final bool interactiveColorChange;

  @override
  NetworkParticleState createState() => NetworkParticleState();
}

enum ParticleShape { circle, square, triangle }

class NetworkParticleState extends State<NetworkParticle> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationController awayAnimationController;
  late double dx;
  late double dy;
  List<Offset> offsets = [];
  List<bool> randDirection = [];
  double speedOfParticle = 0;
  var rng = math.Random();
  double randValue = 0;
  List<double> randomDouble = [];
  List<double> randomSize = [];
  List<int> hoverIndex = [];
  List<List<dynamic>> lineOffset = [];
  List<Color> particleColors = [];
  ValueNotifier<List<Color>> particleColorsNotifier = ValueNotifier<List<Color>>([]);

  void initializeOffsets(_) {
    for (int index = 0; index < widget.numberOfParticles; index++) {
      offsets.add(Offset(rng.nextDouble() * widget.width, rng.nextDouble() * widget.height));
      randomDouble.add(rng.nextDouble());
      randDirection.add(rng.nextBool());
      randomSize.add(rng.nextDouble());
      particleColors.add(widget.particleColor);
    }
    particleColorsNotifier.value = List<Color>.from(particleColors);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(initializeOffsets);
    controller = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)..addListener(_myListener);
    controller.repeat();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NetworkParticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.particleColor != widget.particleColor) {
      updateParticleColors();
    }
  }

  void _myListener() {
    setState(() {
      speedOfParticle = widget.speedOfParticles;
      for (int index = 0; index < offsets.length; index++) {
        if (widget.attractToMouse) {
          var mouseOffset = Offset(dx, dy);
          var diff = mouseOffset - offsets[index];
          var distance = diff.distance;
          if (distance > 0) {
            var direction = diff / distance;
            var attractionForce = speedOfParticle * 0.1;
            offsets[index] += direction * attractionForce;
          }
        } else {
          if (randDirection[index]) {
            randValue = -speedOfParticle;
          } else {
            randValue = speedOfParticle;
          }
          dx = offsets[index].dx + (randValue * randomDouble[index]) + widget.windEffect.dx;
          dy = offsets[index].dy + randomDouble[index] * speedOfParticle + widget.windEffect.dy + widget.gravity;
          if (dx > widget.width) {
            dx = dx - widget.width;
          } else if (dx < 0) {
            dx = dx + widget.width;
          }
          if (dy > widget.height) {
            dy = dy - widget.height;
          } else if (dy < 0) {
            dy = dy + widget.height;
          }
          offsets[index] = Offset(dx, dy);
        }
      }
      if (widget.connectDots) connectLines();
    });
  }

  @override
  void dispose() {
    animation.removeListener(_myListener);
    controller.dispose();
    super.dispose();
  }

  void changeDirection() async {
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      for (int index = 0; index < widget.numberOfParticles; index++) {
        randDirection[index] = rng.nextBool();
      }
      return true;
    });
  }

  void connectLines() {
    lineOffset = [];
    double distanceBetween = 0;
    for (int point1 = 0; point1 < offsets.length; point1++) {
      for (int point2 = 0; point2 < offsets.length; point2++) {
        distanceBetween = math.sqrt(math.pow((offsets[point2].dx - offsets[point1].dx), 2) + math.pow((offsets[point2].dy - offsets[point1].dy), 2));
        if (distanceBetween < 150) {
          lineOffset.add([offsets[point1], offsets[point2], distanceBetween]);
        }
      }
    }
  }

  void onTapGesture(double tapDx, double tapDy) {
    awayAnimationController = AnimationController(duration: widget.awayAnimationDuration, vsync: this);
    awayAnimationController.reset();
    double directionDx;
    double directionDy;
    List<double> distance = [];
    double noAnimationDistance = 0;

    if (widget.onTapAnimation) {
      List<Animation<Offset>> awayAnimation = [];
      awayAnimationController.forward();
      for (int index = 0; index < offsets.length; index++) {
        distance.add(math.sqrt(((tapDx - offsets[index].dx) * (tapDx - offsets[index].dx)) + ((tapDy - offsets[index].dy) * (tapDy - offsets[index].dy))));
        directionDx = (tapDx - offsets[index].dx) / distance[index];
        directionDy = (tapDy - offsets[index].dy) / distance[index];
        Offset begin = offsets[index];
        awayAnimation.add(
          Tween<Offset>(
            begin: begin,
            end: Offset(
              offsets[index].dx - (widget.awayRadius - distance[index]) * directionDx,
              offsets[index].dy - (widget.awayRadius - distance[index]) * directionDy,
            ),
          ).animate(CurvedAnimation(parent: awayAnimationController, curve: widget.awayAnimationCurve))
            ..addListener(() {
              if (distance[index] < widget.awayRadius) {
                setState(() => offsets[index] = awayAnimation[index].value);
              }
              if (awayAnimationController.isCompleted && index == offsets.length - 1) {
                awayAnimationController.dispose();
              }
            }),
        );
      }
    } else {
      for (int index = 0; index < offsets.length; index++) {
        noAnimationDistance = math.sqrt(((tapDx - offsets[index].dx) * (tapDx - offsets[index].dx)) + ((tapDy - offsets[index].dy) * (tapDy - offsets[index].dy)));
        directionDx = (tapDx - offsets[index].dx) / noAnimationDistance;
        directionDy = (tapDy - offsets[index].dy) / noAnimationDistance;
        if (noAnimationDistance < widget.awayRadius) {
          setState(() {
            offsets[index] = Offset(
              offsets[index].dx - (widget.awayRadius - noAnimationDistance) * directionDx,
              offsets[index].dy - (widget.awayRadius - noAnimationDistance) * directionDy,
            );
          });
        }
      }
    }
  }

  void hoverAnimation(double hoverDx, double hoverDy) {
    hoverIndex.clear();
    List<Color> updatedColors = List<Color>.from(particleColorsNotifier.value);
    for (int index = 0; index < offsets.length; index++) {
      double distance = math.sqrt(math.pow((offsets[index].dx - hoverDx), 2) + math.pow((offsets[index].dy - hoverDy), 2));
      if (distance < widget.hoverRadius) {
        hoverIndex.add(index);
        updatedColors[index] = widget.hoverColor;
      } else if (widget.interactiveColorChange) {
        updatedColors[index] = widget.particleColor;
      }
    }
    particleColorsNotifier.value = updatedColors;
  }

  void updateParticleColors() {
    List<Color> updatedColors = List<Color>.from(particleColorsNotifier.value);
    for (int index = 0; index < updatedColors.length; index++) {
      updatedColors[index] = widget.particleColor;
    }
    particleColorsNotifier.value = updatedColors;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        onTapGesture(details.localPosition.dx, details.localPosition.dy);
      },
      onPanUpdate: (details) {
        dx = details.localPosition.dx;
        dy = details.localPosition.dy;
        if (widget.enableHover) {
          hoverAnimation(dx, dy);
        }
      },
      onPanEnd: (details) {
        hoverIndex.clear();
        if (widget.interactiveColorChange) {
          List<Color> updatedColors = List<Color>.from(particleColorsNotifier.value);
          for (int index in hoverIndex) {
            updatedColors[index] = widget.particleColor;
          }
          particleColorsNotifier.value = updatedColors;
        }
      },
      child: ValueListenableBuilder<List<Color>>(
        valueListenable: particleColorsNotifier,
        builder: (context, particleColors, _) {
          return CustomPaint(
            painter: MyPainter(
              offsets: offsets,
              randColorList: widget.randColorList,
              speedOfParticle: widget.speedOfParticles,
              isRandomColor: widget.isRandomColor,
              particleColor: widget.particleColor,
              maxParticleSize: widget.maxParticleSize,
              isRandSize: widget.isRandSize,
              hoverIndex: hoverIndex,
              hoverColor: widget.hoverColor,
              connectDots: widget.connectDots,
              lineOffset: lineOffset,
              lineColor: widget.lineColor,
              lineStrokeWidth: widget.lineStrokeWidth,
              particleShape: widget.particleShape,
              fadeEffect: widget.fadeEffect,
              fadeOpacity: widget.fadeOpacity,
              particleColors: particleColors,
            ),
            size: Size(widget.width, widget.height),
          );
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset> offsets;
  final List<Color> randColorList;
  final double speedOfParticle;
  final bool isRandomColor;
  final Color particleColor;
  final double maxParticleSize;
  final bool isRandSize;
  final List<int> hoverIndex;
  final Color hoverColor;
  final bool connectDots;
  final List<List<dynamic>> lineOffset;
  final Color lineColor;
  final double lineStrokeWidth;
  final ParticleShape particleShape;
  final bool fadeEffect;
  final double fadeOpacity;
  final List<Color> particleColors;
  final math.Random rng = math.Random();

  MyPainter({
    required this.offsets,
    required this.randColorList,
    required this.speedOfParticle,
    required this.isRandomColor,
    required this.particleColor,
    required this.maxParticleSize,
    required this.isRandSize,
    required this.hoverIndex,
    required this.hoverColor,
    required this.connectDots,
    required this.lineOffset,
    required this.lineColor,
    required this.lineStrokeWidth,
    required this.particleShape,
    required this.fadeEffect,
    required this.fadeOpacity,
    required this.particleColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeCap = StrokeCap.round;

    if (connectDots) {
      for (int i = 0; i < lineOffset.length; i++) {
        paint
          ..strokeWidth = lineStrokeWidth
          ..color = lineColor;
        canvas.drawLine(lineOffset[i][0] as Offset, lineOffset[i][1] as Offset, paint);
      }
    }

    for (int i = 0; i < offsets.length; i++) {
      if (isRandSize) {
        paint
          ..strokeWidth = rng.nextDouble() * maxParticleSize
          ..color = particleColors[i].withOpacity(fadeEffect ? fadeOpacity : 1);
      } else {
        paint
          ..strokeWidth = maxParticleSize
          ..color = particleColors[i].withOpacity(fadeEffect ? fadeOpacity : 1);
      }
      switch (particleShape) {
        case ParticleShape.circle:
          canvas.drawCircle(offsets[i], maxParticleSize, paint);
          break;
        case ParticleShape.square:
          canvas.drawRect(
            Rect.fromCenter(center: offsets[i], width: maxParticleSize * 2, height: maxParticleSize * 2),
            paint,
          );
          break;
        case ParticleShape.triangle:
          var path = Path();
          path.moveTo(offsets[i].dx, offsets[i].dy - maxParticleSize);
          path.lineTo(offsets[i].dx - maxParticleSize, offsets[i].dy + maxParticleSize);
          path.lineTo(offsets[i].dx + maxParticleSize, offsets[i].dy + maxParticleSize);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


