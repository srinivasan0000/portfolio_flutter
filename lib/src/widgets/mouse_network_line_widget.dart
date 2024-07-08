// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MouseNetworkLineWidget extends StatefulWidget {
  final List<Widget> children;
  final double pointFromY;
  final double pointFromX;

  const MouseNetworkLineWidget({super.key, required this.children, this.pointFromY = 0.0, this.pointFromX = 0.0});

  @override
  State<MouseNetworkLineWidget> createState() => _MouseNetworkLineWidgetState();
}

class _MouseNetworkLineWidgetState extends State<MouseNetworkLineWidget> {
  Offset? _mousePosition;
  final List<GlobalKey> _childKeys = [];
  final GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _childKeys.addAll(List.generate(widget.children.length, (_) => GlobalKey()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onHover: (event) {
        setState(() {
          RenderBox? stackRenderBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
          if (stackRenderBox != null) {
            _mousePosition = stackRenderBox.globalToLocal(event.position);
          }
        });
      },
      onExit: (event) {
        setState(() {
          _mousePosition = null;
        });
      },
      child: SizedBox(
        key: _stackKey,
        width: double.infinity,
        // height: double.infinity,
        child: Stack(
          children: [
            Wrap(
              spacing: size.width < 450 ? 25 : 50,
              children: List.generate(widget.children.length, (index) {
                return Container(
                  key: _childKeys[index],
                  child: widget.children[index],
                );
              }),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: LinePainter(
                  pointFromY: widget.pointFromY,
                  pointFromX: widget.pointFromX,
                  mousePosition: _mousePosition,
                  childKeys: _childKeys,
                  stackKey: _stackKey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset? mousePosition;
  final List<GlobalKey> childKeys;
  final GlobalKey stackKey;
  final double pointFromY;
  final double pointFromX;

  LinePainter({this.mousePosition, required this.childKeys, required this.stackKey, required this.pointFromY, required this.pointFromX});

  @override
  void paint(Canvas canvas, Size size) {
    if (mousePosition == null) return;

    final paint = Paint()
      // ..color = Colors.transparent
      // ..maskFilter = MaskFilter.blur(BlurStyle.solid, 50)
      ..shader = const LinearGradient(colors: [
        Colors.black,
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.purple,
      ], stops: [
        0.0,
        0.25,
        0.5,
        0.75,
        1.0
      ], transform: GradientRotation(0.5), tileMode: TileMode.repeated)
          .createShader(Rect.fromCircle(center: mousePosition!, radius: 100))
      // ..colorFilter = ColorFilter. mode(Colors.black, BlendMode. colorDodge)
      ..strokeWidth = 2;

    for (var key in childKeys) {
      final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final Offset childPosition = renderBox.localToGlobal(Offset.zero);
        RenderBox? stackRenderBox = stackKey.currentContext?.findRenderObject() as RenderBox?;
        if (stackRenderBox != null) {
          final Offset localChildPosition = stackRenderBox.globalToLocal(childPosition);
          final Offset centerChild = Offset(
            localChildPosition.dx + renderBox.size.width / 2 + (pointFromX),
            localChildPosition.dy + renderBox.size.height / 2 + (pointFromY),
          );
          canvas.drawLine(mousePosition!, centerChild, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
