import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractiveShadowWidget extends StatelessWidget {
  const InteractiveShadowWidget({super.key, this.updateMousePosition, this.resetMousePosition});
  final void Function(PointerHoverEvent)? updateMousePosition;
  final void Function(PointerExitEvent)? resetMousePosition;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onHover: updateMousePosition,
        onExit: resetMousePosition,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Text('Interactive Shadow Widget'),
            ),
          ),
        ));
  }
}
