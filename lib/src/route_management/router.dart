import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/boring/boring_page.dart';
import '../screens/home/home_page.dart';
import '../screens/simulations/pendulum/pendulum_page.dart';

import '../screens/simulations/metaballs_page.dart';
import '../screens/simulations/sparcle_particle/demo.dart';
import '../widgets/mouse_follower_widget/mouse_follower_widget.dart';
import '../widgets/mouse_follower_widget/mouse_style_stacks.dart';
import '../widgets/mouse_follower_widget/mouse_style_widget.dart';

GoRouter router = GoRouter(initialLocation: '/Home', routes: [
  GoRoute(path: '/Home', name: Routes.splash.name, builder: (context, state) => const HomeWrapper(), routes: [
    GoRoute(path: 'FeelingBored', name: Routes.boring.name, builder: (context, state) => const BoringPage(), routes: [
      GoRoute(path: 'Pendulum', name: Routes.pendulum.name, builder: (context, state) => const PendulumPage()),
      GoRoute(path: 'MetaBalls', name: Routes.metaballs.name, builder: (context, state) => const MetalBallsPage()),
      GoRoute(path: 'Sparkles', name: Routes.sparkles.name, builder: (context, state) => const SparklePartyDemo())
    ])
  ]),
]);

enum Routes {
  splash,
  home,
  boring,
  pendulum,
  metaballs,
  sparkles,
}

class HomeWrapper extends ConsumerWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMouseStyleStack = ref.watch(appMouseStackStyleProvider);
    return MouseFollower(
        onHoverMouseCursor: SystemMouseCursors.click,
        isVisible: true,
        onHoverMouseStylesStack: [
          MouseStyle(
            size: const Size(50, 50),
            latency: const Duration(milliseconds: 25),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withAlpha(150)),
          ),
        ],
        mouseStylesStack: getMouseStyleStack(appMouseStyleStack, context),
        child: const HomePage());
    // const HomePage();
  }
}
