import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  final Widget desktop;
  final Widget? mobile;
  final Widget? tablet;

  static bool isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 500;

  static bool isLargeScreen(BuildContext context) => MediaQuery.of(context).size.width > 1200;

  static bool isMediumScreen(BuildContext context) => MediaQuery.of(context).size.width >= 550 && MediaQuery.of(context).size.width <= 1200;

  @override
  Widget build(BuildContext context) {
    if (isLargeScreen(context)) {
      return desktop;
    } else if (isMediumScreen(context)) {
      return tablet ?? desktop;
    } else {
      return mobile ?? desktop;
    }
  }
}
