import 'package:flutter/material.dart';

extension ColorsHex on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

extension ContextExtentions on BuildContext {
  ColorScheme get colorTheme => Theme.of(this).colorScheme;
}

extension StringHardcoded on String {
  String get hardcoded => this;
}

extension StringExtension on String {
  String capitalizeIt() {
    return this[0].toUpperCase() + substring(1);
  }
}
