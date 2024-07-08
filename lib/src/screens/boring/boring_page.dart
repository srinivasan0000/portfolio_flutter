// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../route_management/router.dart';

class BoringPage extends ConsumerStatefulWidget {
  const BoringPage({super.key});

  @override
  ConsumerState<BoringPage> createState() => _BoringPageState();
}

class _BoringPageState extends ConsumerState<BoringPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSection(
                "Simulations",
                [
                  const _SimWidget(page: Routes.metaballs, title: "MetalBalls", icon: Icons.bubble_chart),
                  const _SimWidget(page: Routes.pendulum, title: "Pendulum", icon: Icons.circle),
                  const _SimWidget(page: Routes.sparkles, title: "Sparkles", icon: Icons.auto_awesome),
                ],
                showpop: true),
            _buildSection("Games", [
              // _SimWidget(page: TetrisPage(), title: "Tetris", icon: Icons.grid_on),
              // _SimWidget(page: SnakePage(), title: "Snake", icon: Icons.gesture),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items, {bool showpop = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showpop
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}

class _SimWidget extends StatefulWidget {
  const _SimWidget({
    required this.page,
    required this.title,
    required this.icon,
  });

  final Routes page;
  final String title;
  final IconData icon;

  @override
  _SimWidgetState createState() => _SimWidgetState();
}

class _SimWidgetState extends State<_SimWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    isHovered ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            onTap: () {
              context.pushNamed(widget.page.name);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                color: _isHovered ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
                    blurRadius: _isHovered ? 15 : 10,
                    offset: Offset(0, _isHovered ? 8 : 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: _isHovered ? const Offset(0, -0.1) : Offset.zero,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _isHovered ? 0.05 : 0,
                      child: Icon(widget.icon, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: _isHovered ? 1.1 : 1.0,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(widget.page.name);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isHovered ? Colors.white : Colors.white.withOpacity(0.8),
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Play'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

