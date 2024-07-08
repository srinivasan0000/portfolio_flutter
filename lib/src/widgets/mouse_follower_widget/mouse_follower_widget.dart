import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mouse_follower_state.dart';
import 'mouse_style_widget.dart';

class MouseFollower extends ConsumerWidget {
  final Widget child;

  final List<MouseStyle>? mouseStylesStack;

  final List<MouseStyle>? onHoverMouseStylesStack;

  final bool showDefaultMouseStyle;

  final bool? isVisible;

  final MouseCursor defaultMouseCursor;
  final MouseCursor onHoverMouseCursor;

  const MouseFollower({
    super.key,
    required this.child,
    this.mouseStylesStack,
    this.onHoverMouseStylesStack,
    this.showDefaultMouseStyle = true,
    this.isVisible,
    this.defaultMouseCursor = MouseCursor.defer,
    this.onHoverMouseCursor = MouseCursor.defer,
  });

  void _onCursorUpdate(PointerEvent event, WidgetRef ref) =>
      ref.read(mouseFollowerProvider.notifier).updateCursorPosition(event.position);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mouseFollowerProvider);
    final bool visibility;

    Widget ccc = MouseRegion(
      cursor: state.isHover ? state.customMouseCursor ?? onHoverMouseCursor : defaultMouseCursor,
      child: child,
    );

    if (isVisible == null) {
      visibility = MediaQuery.of(context).size.width > 750;
    } else {
      visibility = isVisible!;
    }

    List<MouseStyle> generatedMouseStylesStack = [];
    List<MouseStyle> generatedOnHoverMouseStylesStack = [];

    if (mouseStylesStack != null && mouseStylesStack!.isNotEmpty) {
      generatedMouseStylesStack =
          mouseStylesStack!.map((item) => MouseStyle.copy(item, showVisibleOnHover: item.visibleOnHover)).toList();
    } else if (showDefaultMouseStyle) {
      generatedMouseStylesStack.add(MouseStyle(
          decoration: state.decoration.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.2)),
          visibleOnHover: false));
    }

    if (state.isHover && state.customOnHoverMouseStylesStack != null) {
      generatedOnHoverMouseStylesStack =
          state.customOnHoverMouseStylesStack!.map((item) => MouseStyle.copy(item, showVisibleOnHover: true)).toList();
    } else if (onHoverMouseStylesStack != null && onHoverMouseStylesStack!.isNotEmpty) {
      generatedOnHoverMouseStylesStack =
          onHoverMouseStylesStack!.map((item) => MouseStyle.copy(item, showVisibleOnHover: true)).toList();
    } else if (showDefaultMouseStyle) {
      generatedOnHoverMouseStylesStack.add(MouseStyle(
          size: const Size(36, 36),
          decoration: state.decoration.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.2)),
          visibleOnHover: true));
    }

    List<Widget> defaultList = [
      ccc,
      Positioned.fill(
        child: MouseRegion(
          opaque: false,
          onHover: (e) => _onCursorUpdate(e, ref),
        ),
      ),
    ];

    List<Widget> mouseStyleListBackground = !state.isHover
        ? defaultList + generatedMouseStylesStack
        : defaultList +
            generatedMouseStylesStack.where((element) => element.visibleOnHover == true).toList() +
            generatedOnHoverMouseStylesStack;

    return visibility
        ? Stack(
            alignment: AlignmentDirectional.topStart,
            textDirection: TextDirection.ltr,
            children: mouseStyleListBackground,
          )
        : ccc;
  }
}
