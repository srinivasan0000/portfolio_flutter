import 'dart:math' as math;

import 'package:flutter/material.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.overlayColor,
    this.splashColor,
    this.animationDuration = const Duration(milliseconds: 250),
    this.openIcon = Icons.add,
    this.closeIcon = Icons.close,
    this.glowColor,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final Color? overlayColor;
  final Color? splashColor;
  final Duration animationDuration;
  final IconData openIcon;
  final IconData closeIcon;
  final Color? glowColor;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _glowAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: widget.animationDuration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
    _glowAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return AnimatedOpacity(
      opacity: _open ? 1.0 : 0.0,
      duration: widget.animationDuration,
      child: SizedBox(
        width: 56,
        height: 56,
        child: Center(
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: widget.elevation,
            color: widget.backgroundColor ?? Theme.of(context).primaryColor,
            child: InkWell(
              onTap: _toggle,
              splashColor: widget.splashColor,
              overlayColor: WidgetStateProperty.all(widget.overlayColor),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  widget.closeIcon,
                  color: widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    final glowColor = widget.glowColor ?? Theme.of(context).primaryColor.withOpacity(0.5);
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: widget.animationDuration,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: widget.animationDuration,
          child: GlowingOverlay(
            glowColor: glowColor,
            child: AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _glowAnimation.value,
                  child: child,
                );
              },
              child: FloatingActionButton(
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.foregroundColor,
                splashColor: widget.splashColor,
                elevation: widget.elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                onPressed: _toggle,
                child: _AnimatedIcon(
                  progress: _expandAnimation,
                  openIcon: widget.openIcon,
                  closeIcon: widget.closeIcon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedIcon extends StatelessWidget {
  const CustomAnimatedIcon({
    super.key,
    required this.progress,
    required this.color,
  });

  final Animation<double> progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Transform.rotate(
          angle: progress.value * math.pi / 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildBar(math.pi / 4),
              _buildBar(-math.pi / 4),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBar(double angle) {
    return Transform.rotate(
      angle: angle + (progress.value * math.pi / 4),
      child: Container(
        width: 24,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class GlowingOverlay extends StatelessWidget {
  final Widget child;
  final Color glowColor;

  const GlowingOverlay({
    super.key,
    required this.child,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _AnimatedIcon extends StatelessWidget {
  const _AnimatedIcon({
    required this.progress,
    required this.openIcon,
    required this.closeIcon,
  });

  final Animation<double> progress;
  final IconData openIcon;
  final IconData closeIcon;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Transform.rotate(
          angle: progress.value * math.pi,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 1 - progress.value,
                child: Icon(openIcon),
              ),
              Opacity(
                opacity: progress.value,
                child: Icon(closeIcon),
              ),
            ],
          ),
        );
      },
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 4.0,
    this.splashColor,
    this.tooltipText,
    this.glowColor,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final Color? splashColor;
  final String? tooltipText;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveGlowColor = glowColor ?? theme.colorScheme.secondary.withOpacity(0.3);

    final button = GlowingOverlay(
      glowColor: effectiveGlowColor,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: backgroundColor ?? theme.colorScheme.secondary,
        elevation: elevation,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          color: foregroundColor ?? theme.colorScheme.onSecondary,
          splashColor: splashColor,
        ),
      ),
    );

    if (tooltipText != null) {
      return Tooltip(
        message: tooltipText!,
        child: button,
      );
    }

    return button;
  }
} 
