import 'package:flutter/material.dart';

class HeartbeatWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleBegin;
  final double scaleEnd;

  const HeartbeatWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.scaleBegin = 0.8,
    this.scaleEnd = 1,
  });

  @override
  State<HeartbeatWidget> createState() => _HeartbeatWidgetState();
}

class _HeartbeatWidgetState extends State<HeartbeatWidget> {
  bool _isScaledUp = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _isScaledUp = !_isScaledUp;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isScaledUp ? widget.scaleEnd : widget.scaleBegin,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
