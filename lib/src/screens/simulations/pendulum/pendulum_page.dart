// ignore_for_file: inference_failure_on_function_return_type

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/src/core/extensions/material_extensions.dart';

class PendulumPage extends StatelessWidget {
  const PendulumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorTheme.primary.withOpacity(0.2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Sample Pendulum Simulation'),
          automaticallyImplyLeading: true,
        ),
        body: const PendulumSimulation(),
      ),
    );
  }
}

class PendulumSimulation extends StatefulWidget {
  const PendulumSimulation({super.key});

  @override
  State<PendulumSimulation> createState() => _PendulumSimulationState();
}

class _PendulumSimulationState extends State<PendulumSimulation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0.0;
  double _angularVelocity = 0.0;
  double _length = 0.70;
  double _mass = 1.00;
  double _gravity = 9.8;
  double _friction = 0.1;
  bool _isRunning = false;
  bool _isDragging = false;
  bool _showTrail = false;
  final List<Offset> _trail = [];
  int _trailLength = 50;
  String _planet = 'Custom';
  final Map<String, Map<String, double>> _planetData = {
    'Mercury': {'gravity': 3.7, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Venus': {'gravity': 8.87, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Earth': {'gravity': 9.8, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Mars': {'gravity': 3.71, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Jupiter': {'gravity': 24.79, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Saturn': {'gravity': 10.44, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Uranus': {'gravity': 8.87, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Neptune': {'gravity': 11.15, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Moon': {'gravity': 1.62, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
    'Custom': {'gravity': 9.8, 'maxLength': 1.5, 'maxMass': 2.0, 'maxFriction': 0.15},
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updatePendulum);
  }

  void _updatePendulum() {
    if (_isRunning && !_isDragging) {
      setState(() {
        double angularAcceleration = -_gravity / (_length * 300) * math.sin(_angle);
        angularAcceleration -= _friction * _angularVelocity / _mass;
        _angularVelocity += angularAcceleration;
        _angle += _angularVelocity;

        _angle = _angle % (2 * math.pi);

        if (_showTrail) {
          _updateTrail();
        }
      });
    }
  }

  void _updateTrail() {
    final center = Offset(MediaQuery.of(context).size.width / 2, 20);
    final endPoint = center + Offset(math.sin(_angle) * _length * 300, math.cos(_angle) * _length * 300);
    _trail.add(endPoint);
    if (_trail.length > _trailLength) {
      _trail.removeAt(0);
    }
  }

  void _toggleSimulation() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _controller.repeat(period: const Duration(milliseconds: 16));
      } else {
        _controller.stop();
      }
    });
  }

  void _resetSimulation() {
    setState(() {
      _angle = 0.0;
      _angularVelocity = 0.0;
      _isRunning = false;
      _trail.clear();
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      Offset localPosition = details.localPosition;
      double centerX = MediaQuery.of(context).size.width / 2;
      double centerY = 20;
      _angle = math.atan2(localPosition.dx - centerX, localPosition.dy - centerY);
      _angularVelocity = 0;
      if (_showTrail) {
        _updateTrail();
      }
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  void _updatePlanet(String? newPlanet) {
    if (newPlanet != null) {
      setState(() {
        _planet = newPlanet;
        _gravity = _planetData[_planet]!['gravity']!;
        _mass = math.min(_mass, _planetData[_planet]!['maxMass']!);
        _friction = math.min(_friction, _planetData[_planet]!['maxFriction']!);
      });
    }
  }

  void _updateGravity(double newGravity) {
    setState(() {
      _gravity = newGravity;
      _planet = 'Custom';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              GestureDetector(
                onPanUpdate: _handlePanUpdate,
                onPanEnd: _handlePanEnd,
                child: CustomPaint(
                  painter: PendulumPainter(_angle, _length, _mass, _trail, _showTrail),
                  child: Container(),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                bottom: 10,
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.yellow.shade100, Colors.yellow.shade900],
                    ),
                  ),
                  child: CustomPaint(
                    painter: RulerPainter(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildDropdown(),
                  _buildSlider('Gravity', _gravity, 0.1, 25.0, _updateGravity),
                  _buildSlider('Length', _length, 0.1, 1.5, (value) => setState(() => _length = value)),
                  _buildSlider('Mass', _mass, 0.1, 2.0, (value) => setState(() => _mass = value)),
                  _buildSlider('Friction', _friction, 0, 0.15, (value) => setState(() => _friction = value)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _toggleSimulation,
                        child: Text(_isRunning ? 'Pause' : 'Start'),
                      ),
                      ElevatedButton(
                        onPressed: _resetSimulation,
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: const Text('Show Trail'),
                    value: _showTrail,
                    onChanged: (value) => setState(() => _showTrail = value!),
                  ),
                  _buildSlider('Trail Length', _trailLength.toDouble(), 10, 200, (value) => setState(() => _trailLength = value.toInt())),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Row(
      children: [
        Text('$label: ${value.toStringAsFixed(2)}'),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Row(
      children: [
        const Text('Planet: '),
        DropdownButton<String>(
          value: _planet,
          onChanged: _updatePlanet,
          items: _planetData.keys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class PendulumPainter extends CustomPainter {
  final double angle;
  final double length;
  final double mass;
  final List<Offset> trail;
  final bool showTrail;

  PendulumPainter(this.angle, this.length, this.mass, this.trail, this.showTrail);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, 20);
    final endPoint = center + Offset(math.sin(angle) * length * 300, math.cos(angle) * length * 300);

    if (showTrail) {
      final trailPaint = Paint()
        ..color = Colors.red.withOpacity(0.5)
        ..strokeWidth = 1;
      for (int i = 0; i < trail.length - 1; i++) {
        canvas.drawLine(trail[i], trail[i + 1], trailPaint);
      }
    }

    canvas.drawLine(center, endPoint, paint);
    canvas.drawCircle(endPoint, 10 + mass * 10, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(PendulumPainter oldDelegate) =>
      angle != oldDelegate.angle || length != oldDelegate.length || mass != oldDelegate.mass || trail != oldDelegate.trail || showTrail != oldDelegate.showTrail;
}

class RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    for (int i = 0; i <= 100; i++) {
      double y = i * size.height / 100;
      double lineLength = i % 10 == 0 ? 20 : (i % 5 == 0 ? 15 : 10);
      canvas.drawLine(Offset(size.width - lineLength, y), Offset(size.width, y), paint);

      if (i % 10 == 0) {
        TextPainter(
          text: TextSpan(text: '${100 - i}', style: const TextStyle(color: Colors.black, fontSize: 10)),
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(canvas, Offset(0, y - 5));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
