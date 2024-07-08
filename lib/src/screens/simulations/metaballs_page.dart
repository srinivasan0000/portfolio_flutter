import 'package:flutter/material.dart';
import 'package:metaballs/metaballs.dart';

class MetalBallsPage extends StatefulWidget {
  const MetalBallsPage({super.key});

  @override
  State<MetalBallsPage> createState() => _MetalBallsPageState();
}

class _MetalBallsPageState extends State<MetalBallsPage> {
  int colorEffectIndex = 0;
  final List<ColorsEffectPair> _colorsAndEffects = [
    ColorsEffectPair(colors: [
      const Color.fromARGB(255, 255, 21, 0),
      const Color.fromARGB(255, 255, 153, 0),
    ], effect: MetaballsEffect.follow(), name: 'FOLLOW'),
    ColorsEffectPair(colors: [
      const Color.fromARGB(255, 0, 255, 106),
      const Color.fromARGB(255, 255, 251, 0),
    ], effect: MetaballsEffect.grow(), name: 'GROW'),
    ColorsEffectPair(colors: [
      const Color.fromARGB(255, 90, 60, 255),
      const Color.fromARGB(255, 120, 255, 255),
    ], effect: MetaballsEffect.speedup(), name: 'SPEEDUP'),
    ColorsEffectPair(colors: [
      const Color.fromARGB(255, 255, 60, 120),
      const Color.fromARGB(255, 237, 120, 255),
    ], effect: MetaballsEffect.ripple(), name: 'RIPPLE'),
    ColorsEffectPair(colors: [
      const Color.fromARGB(255, 120, 217, 255),
      const Color.fromARGB(255, 255, 234, 214),
    ], effect: null, name: 'NONE'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: () {
          setState(() {
            colorEffectIndex = (colorEffectIndex + 1) % _colorsAndEffects.length;
          });
        },
        child: Metaballs(
          effect: _colorsAndEffects[colorEffectIndex].effect,
          glowRadius: 1,
          glowIntensity: 0.5,
          maxBallRadius: 50,
          minBallRadius: 20,
          metaballs: 40,
          color: Colors.grey,
          gradient: LinearGradient(colors: _colorsAndEffects[colorEffectIndex].colors, begin: Alignment.bottomRight, end: Alignment.topLeft),
          child: Column(
            children: [
              Text("Double tap to change effect", style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white)),
              Text(_colorsAndEffects[colorEffectIndex].name, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.yellow)),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorsEffectPair {
  final List<Color> colors;
  final MetaballsEffect? effect;
  final String name;

  ColorsEffectPair({
    required this.colors,
    required this.name,
    required this.effect,
  });
}
