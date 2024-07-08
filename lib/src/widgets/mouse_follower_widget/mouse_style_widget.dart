import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mouse_follower_state.dart';

class MouseStyle extends ConsumerWidget {
  final Widget? child;
  final Size size;
  final BoxDecoration? decoration;
  final Duration latency;
  final Alignment? alignment;
  final bool opaque;
  final Duration animationDuration;
  final Curve? animationCurve;
  final Matrix4? transform;
  final bool visibleOnHover;
  final double opacity;

  const MouseStyle({
    super.key,
    this.child,
    this.size = const Size(15, 15),
    this.decoration,
    this.latency = const Duration(milliseconds: 25),
    this.alignment = Alignment.center,
    this.opacity = 1.0,
    this.opaque = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutExpo,
    this.transform,
    this.visibleOnHover = false,
  });

  MouseStyle.copy(MouseStyle other, {super.key, required bool showVisibleOnHover})
      : visibleOnHover = showVisibleOnHover,
        size = other.size,
        latency = other.latency,
        child = other.child,
        decoration = other.decoration,
        alignment = other.alignment,
        animationDuration = other.animationDuration,
        animationCurve = other.animationCurve,
        opacity = other.opacity,
        opaque = other.opaque,
        transform = other.transform;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mouseFollowerProvider);

    final isHovering = state.isHover;

    double w;
    double h;

    if (isHovering && state.size != null) {
      w = state.size?.width ?? size.width;
      h = state.size?.height ?? size.height;
    } else {
      w = size.width;
      h = size.height;
    }

    final shouldShow = visibleOnHover == true ? true : !isHovering;

    BoxDecoration? dec;
    if (isHovering) {
      dec = state.customDecoration ?? decoration;
    } else {
      dec = decoration;
    }

    Alignment cursorAlignment;
    if (isHovering && state.alignment != null) {
      cursorAlignment = state.alignment ?? alignment ?? Alignment.center;
    } else {
      cursorAlignment = alignment ?? Alignment.center;
    }

    double? t;
    double? l;
    if (cursorAlignment == Alignment.center) {
      t = state.offset.dy - h / 2;
      l = state.offset.dx - w / 2;
    } else if (alignment == Alignment.centerRight) {
      t = state.offset.dy - h / 2;
      l = state.offset.dx;
    } else if (alignment == Alignment.centerLeft) {
      t = state.offset.dy - h / 2;
      l = state.offset.dx - w;
    } else if (alignment == Alignment.bottomCenter) {
      t = state.offset.dy;
      l = state.offset.dx - w / 2;
    } else if (alignment == Alignment.bottomRight) {
      t = state.offset.dy;
      l = state.offset.dx;
    } else if (alignment == Alignment.bottomLeft) {
      t = state.offset.dy;
      l = state.offset.dx - w;
    } else if (alignment == Alignment.topCenter) {
      t = state.offset.dy - h;
      l = state.offset.dx - w / 2;
    } else if (alignment == Alignment.topRight) {
      t = state.offset.dy - h;
      l = state.offset.dx;
    } else if (alignment == Alignment.topLeft) {
      t = state.offset.dy - h;
      l = state.offset.dx - w;
    } else {
      t = state.offset.dy - h / 2;
      l = state.offset.dx - w / 2;
    }

    Duration mouseLatency;
    if (isHovering && state.latency != null) {
      mouseLatency = state.latency ?? latency;
    } else {
      mouseLatency = latency;
    }

    Duration? animatedDuration;
    if (isHovering && state.animationDuration != null) {
      animatedDuration = state.animationDuration;
    } else {
      animatedDuration = animatedDuration;
    }

    Curve? animatedCurve;
    if (isHovering && state.animationCurve != null) {
      animatedCurve = state.animationCurve;
    } else {
      animatedCurve = animationCurve;
    }

    double? customOpacity;
    if (isHovering && state.opacity != null) {
      customOpacity = state.opacity;
    } else {
      customOpacity = opacity;
    }

    return Visibility(
      visible: shouldShow,
      child: AnimatedPositioned(
        top: t,
        left: l,
        width: w,
        height: h,
        duration: mouseLatency,
        child: IgnorePointer(
          child: Opacity(
            opacity: customOpacity ?? 1.0,
            child: AnimatedContainer(
              transform: transform,
              alignment: Alignment.center,
              clipBehavior: dec == null ? Clip.none : Clip.antiAliasWithSaveLayer,
              decoration: dec,
              duration: animatedDuration ?? const Duration(milliseconds: 300),
              curve: animatedCurve ?? Curves.easeOutExpo,
              child: (isHovering && state.child != null && state.child.runtimeType != MouseStyle) ? state.child : child,
            ),
          ),
        ),
      ),
    );
  }
}

class MouseOnHoverEvent extends ConsumerStatefulWidget {
  const MouseOnHoverEvent(
      {super.key,
      required this.child,
      this.decoration,
      this.size,
      this.mouseChild,
      this.onHoverMouseCursor,
      this.customOnHoverMouseStylesStack,
      this.animationCurve,
      this.animationDuration,
      this.opacity,
      this.alignment,
      this.latency});

  final Widget child;

  final BoxDecoration? decoration;

  final Size? size;

  final Widget? mouseChild;

  final Duration? latency;

  final MouseCursor? onHoverMouseCursor;
  final List<MouseStyle>? customOnHoverMouseStylesStack;

  final Duration? animationDuration;
  final Curve? animationCurve;
  final Alignment? alignment;
  final double? opacity;

  @override
  ConsumerState<MouseOnHoverEvent> createState() => _MouseOnHoverEventState();
}

class _MouseOnHoverEventState extends ConsumerState<MouseOnHoverEvent> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(mouseFollowerProvider.notifier);

    return MouseRegion(
      key: _key,
      opaque: false,
      onHover: (event) {
        notifier.changeCursor(_key,
            latency: widget.latency,
            mouseCursor: widget.onHoverMouseCursor,
            decoration: widget.decoration,
            mouseChild: widget.mouseChild,
            customOnHoverMouseStylesStack: widget.customOnHoverMouseStylesStack,
            size: widget.size,
            animationCurve: widget.animationCurve,
            animationDuration: widget.animationDuration,
            alignment: widget.alignment,
            opacity: widget.opacity,
            event: event);
      },
      onExit: (_) => notifier.resetCursor(),
      child: widget.child,
    );
  }
}
