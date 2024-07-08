import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mouse_style_widget.dart';

class MouseFollowerState {
  const MouseFollowerState({
    this.offset = Offset.zero,
    this.size = const Size(15, 15),
    this.decoration = kDefaultDecoration,
    this.customMouseCursor = MouseCursor.defer,
    this.alignment = Alignment.center,
    this.isHover = false,
    this.customDecoration,
    this.child,
    this.latency,
    this.animationDuration,
    this.animationCurve,
    this.customOnHoverMouseStylesStack,
    this.opacity,
  });

  static const BoxDecoration kDefaultDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.blue,
  );

  final BoxDecoration decoration;
  final BoxDecoration? customDecoration;
  final MouseCursor? customMouseCursor;
  final Offset offset;
  final Size? size;
  final Widget? child;
  final bool isHover;
  final Duration? latency;
  final Alignment? alignment;
  final List<MouseStyle>? customOnHoverMouseStylesStack;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? opacity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MouseFollowerState &&
        other.decoration == decoration &&
        other.customDecoration == customDecoration &&
        other.customMouseCursor == customMouseCursor &&
        other.offset == offset &&
        other.size == size &&
        other.child == child &&
        other.isHover == isHover &&
        other.latency == latency &&
        other.alignment == alignment &&
        listEquals(other.customOnHoverMouseStylesStack, customOnHoverMouseStylesStack) &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.opacity == opacity;
  }

  @override
  int get hashCode {
    return decoration.hashCode ^
        customDecoration.hashCode ^
        customMouseCursor.hashCode ^
        offset.hashCode ^
        size.hashCode ^
        child.hashCode ^
        isHover.hashCode ^
        latency.hashCode ^
        alignment.hashCode ^
        customOnHoverMouseStylesStack.hashCode ^
        animationDuration.hashCode ^
        animationCurve.hashCode ^
        opacity.hashCode;
  }

  MouseFollowerState copyWith({
    BoxDecoration? decoration,
    ValueGetter<BoxDecoration?>? customDecoration,
    ValueGetter<MouseCursor?>? customMouseCursor,
    Offset? offset,
    ValueGetter<Size?>? size,
    ValueGetter<Widget?>? child,
    bool? isHover,
    ValueGetter<Duration?>? latency,
    ValueGetter<Alignment?>? alignment,
    ValueGetter<List<MouseStyle>?>? customOnHoverMouseStylesStack,
    ValueGetter<Duration?>? animationDuration,
    ValueGetter<Curve?>? animationCurve,
    ValueGetter<double?>? opacity,
  }) {
    return MouseFollowerState(
      decoration: decoration ?? this.decoration,
      customDecoration: customDecoration != null ? customDecoration() : this.customDecoration,
      customMouseCursor: customMouseCursor != null ? customMouseCursor() : this.customMouseCursor,
      offset: offset ?? this.offset,
      size: size != null ? size() : this.size,
      child: child != null ? child() : this.child,
      isHover: isHover ?? this.isHover,
      latency: latency != null ? latency() : this.latency,
      alignment: alignment != null ? alignment() : this.alignment,
      customOnHoverMouseStylesStack:
          customOnHoverMouseStylesStack != null ? customOnHoverMouseStylesStack() : this.customOnHoverMouseStylesStack,
      animationDuration: animationDuration != null ? animationDuration() : this.animationDuration,
      animationCurve: animationCurve != null ? animationCurve() : this.animationCurve,
      opacity: opacity != null ? opacity() : this.opacity,
    );
  }
}

class MouseFollowerNotifier extends StateNotifier<MouseFollowerState> {
  MouseFollowerNotifier() : super(const MouseFollowerState());

  void changeCursor(GlobalKey key,
      {BoxDecoration? decoration,
      Duration? animationDuration,
      Curve? animationCurve,
      MouseCursor? mouseCursor,
      List<MouseStyle>? customOnHoverMouseStylesStack,
      Alignment? alignment,
      Size? size,
      Widget? mouseChild,
      double? opacity,
      Duration? latency,
      required PointerHoverEvent event}) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    state = MouseFollowerState(
      animationCurve: animationCurve,
      animationDuration: animationDuration,
      customDecoration: decoration,
      customMouseCursor: mouseCursor,
      customOnHoverMouseStylesStack: customOnHoverMouseStylesStack,
      size: size,
      alignment: alignment,
      isHover: true,
      opacity: opacity,
      child: mouseChild,
      latency: latency,
      offset: renderBox.localToGlobal(Offset.zero).translate(event.localPosition.dx, event.localPosition.dy),
      decoration:
          MouseFollowerState.kDefaultDecoration.copyWith(color: Colors.blue.withAlpha(80), shape: BoxShape.circle),
    );
  }

  void resetCursor() {
    state = const MouseFollowerState();
  }

  void updateCursorPosition(Offset pos) {
    state = MouseFollowerState(offset: pos);
  }
}

final mouseFollowerProvider = StateNotifierProvider<MouseFollowerNotifier, MouseFollowerState>((ref) {
  return MouseFollowerNotifier();
});
