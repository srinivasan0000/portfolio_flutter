import 'package:flutter/material.dart';
import 'package:my_portfolio/src/core/extensions/material_extensions.dart';

import '../../../core/assets/assets.gen.dart';
import '../shared/env.dart';
import '../shared/ui/blend_mask.dart';
import 'fx_renderer.dart';
import 'fx_entry.dart';
import 'particlefx/fireworks.dart';
import 'particlefx/pinwheel.dart';
import 'particlefx/comet.dart';
import 'particlefx/waterfall.dart';
import 'fx_switcher.dart';
import 'touchpoint_notification.dart';
import 'utils/sprite_sheet.dart';

class SparklePartyDemo extends StatefulWidget {
  static final List<FXEntry> fxs = [
    FXEntry(
      "Waterfall",
      create: (spriteSheet, size) => Waterfall(spriteSheet: spriteSheet, size: size),
    ),
    FXEntry(
      "Fireworks",
      create: (spriteSheet, size) => Fireworks(spriteSheet: spriteSheet, size: size),
    ),
    FXEntry(
      "Comet",
      create: (spriteSheet, size) => Comet(spriteSheet: spriteSheet, size: size),
    ),
    FXEntry(
      "Pinwheel",
      create: (spriteSheet, size) => Pinwheel(spriteSheet: spriteSheet, size: size),
    ),
  ];

  static final List<String> instructions = [
    'TOUCH AND DRAG ON THE SCREEN',
    'TAP OR DRAG ON THE SCREEN',
    'DRAG ON THE SCREEN',
    'DRAG ON THE SCREEN',
  ];

  const SparklePartyDemo({super.key});

  @override
  State<SparklePartyDemo> createState() => _SparklePartyDemoState();
}

class _SparklePartyDemoState extends State<SparklePartyDemo> with TickerProviderStateMixin {
  int _fxIndex = 0;
  int _buttonIndex = 0;

  late final AnimationController _transitionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late final AnimationController _textController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  @override
  void initState() {
    Listenable.merge([_transitionController, _textController]).addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _transitionController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: context.colorTheme.primary.withOpacity(0.2),
        title: const Text(
          'Sparkle Party',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          //Main Background image
          // Positioned.fill(
          //   child: Image.asset(Assets.sparkles.sparklepartyLogo.path, fit: BoxFit.cover),
          // ),

          //Centered logo png
          // Center(
          //   child: Image.asset(Assets.sparkles.sparklepartyLogo.path),
          // ),

          Opacity(
            opacity: 1.0 - _transitionController.value,
            child: NotificationListener<TouchPointChangeNotification>(
              onNotification: _handleInteraction,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FxRenderer(
                    fx: SparklePartyDemo.fxs[_fxIndex],
                    size: constraints.biggest,
                    spriteSheet: SpriteSheet(
                      imageProvider: AssetImage(Assets.sparkles.sparklepartySpritesheet2.path, package: App.pkg),
                      length: 16, // number of frames in the sprite sheet.
                      frameWidth: 64,
                      frameHeight: 64,
                    ),
                  );
                },
              ),
            ),
          ),
          // IgnorePointer(
          //   child: Center(
          //     child: Image.asset(Assets.sparkles.sparklepartyLogoOutline.path, package: App.pkg),
          //   ),
          // ),
          if (!_textController.isCompleted) ...{
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 136),
                child: BlendMask(
                  blendMode: BlendMode.srcOver,
                  opacity: 1.0 - _textController.value,
                  child: Text(
                    SparklePartyDemo.instructions[_fxIndex],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12, package: App.pkg),
                  ),
                ),
              ),
            ),
          },
          FXSwitcher(activeEffect: _buttonIndex, callback: _handleFxChange),
        ],
      ),
    );
  }

  void _handleFxChange(int index) {
    if (index == _fxIndex) return;
    setState(() => _buttonIndex = index);
    _transitionController.forward(from: 0.0).whenComplete(() {
      setState(() => _fxIndex = index);
      _transitionController.reverse(from: 1.0);
      _textController.reverse();
    });
  }

  bool _handleInteraction(TouchPointChangeNotification notification) {
    if (_textController.velocity <= 0) {
      _textController.forward();
    }
    return false;
  }
}

class App {
  static const String _pkg = "sparkle_party";
  static String? get pkg => Env.getPackage(_pkg);
}
