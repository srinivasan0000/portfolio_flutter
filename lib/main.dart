import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion/motion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/route_management/router.dart';
import 'src/services/app_theme.dart';

//todo still this project is in development phase, 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize();
  setPathUrlStrategy();
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(appThemeModeProvider);
    final appThemeColor = ref.watch(appThemeColorProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Porfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(appThemeColor), brightness: appThemeMode == AppThemeMode.light ? Brightness.light : Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: router,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
    );
  }
}
