import 'package:flutter/material.dart';

import '../../widgets/onhover_widgets.dart';
import '../utils/web_utils.dart';

extension HoverExtensions on Widget {
  static final appContainer = TWebUtils.appContainer();

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }

  Widget get moveUpOnHover {
    return MoveUpOnHover(child: this);
  }

  Widget zoomOnHover({double scale = 1.2}) {
    return ZoomOnHover(
      scale: scale,
      child: this,
    );
  }

  Widget fadeTextOnHover({required String hoverText}) {
    return FadedTextOnHover(
      hoverText: hoverText,
      child: this,
    );
  }

  Widget colorShadowOnHover({
    double spreadRadius = 8.0,
    double blurRadius = 20.0,
    double shadowDistance = 10.0,
    double rotationSpeed = 0.1,
    List<Color> shadowColors = const [
      Colors.pink,
      Colors.yellow,
      Colors.green,
      Colors.red,
      Colors.blue,
    ],
  }) {
    return ColorShadowOnHover(
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      shadowDistance: shadowDistance,
      rotationSpeed: rotationSpeed,
      shadowColors: shadowColors,
      child: this,
    );
  }

  Widget mouseShadowOnHover(Offset globalMousePosition, bool isMouseInside) {
    return MouseShadowOnHover(
      globalMousePosition: globalMousePosition,
      isMouseInside: isMouseInside,
      child: this,
    );
  }

}
