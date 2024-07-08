import 'package:flutter/material.dart';

extension OnTapExtensions on Widget {
  Widget flipOnTap() {
    return _FlipOnTapWrapper(child: this);
  }
}

class _FlipOnTapWrapper extends StatefulWidget {
  final Widget child;

  const _FlipOnTapWrapper({required this.child});

  @override
  _FlipOnTapWrapperState createState() => _FlipOnTapWrapperState();
}

class _FlipOnTapWrapperState extends State<_FlipOnTapWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              // ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value * 3.14),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
