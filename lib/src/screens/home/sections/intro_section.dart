import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion/motion.dart';
import '../../../core/extensions/hover_extensions.dart';
import '../../../core/extensions/material_extensions.dart';
import '../../../core/extensions/on_tap_extensions.dart';
import '../../../core/utils/size_utils.dart';

import '../../../core/utils/web_utils.dart';
import '../../../services/app_theme.dart';
import '../../../widgets/network_particle_widget.dart';
import '../../../widgets/responsive_widget.dart';

class IntroSection extends ConsumerStatefulWidget {
  const IntroSection({super.key});
  @override
  ConsumerState<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends ConsumerState<IntroSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveWidget(
      desktop: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.maxFinite,
        // color: Theme.of(context).colorScheme.surface,
        color: context.colorTheme.surface,
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return NetworkParticle(
                lineStrokeWidth: 0.2,
                maxParticleSize: 4,
                lineColor: context.colorTheme.tertiary.withOpacity(0.4),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                particleColor: context.colorTheme.primary,
                // attractToMouse: true,
                connectDots: true,
                // windEffect: Offset(5, 7),
                isRandomColor: true,
                enableHover: true,
                numberOfParticles: 100,
                gravity: 0,
                interactiveColorChange: true,
              );
            }),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: 500,
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: TSizeUtils.hPercent(30, context: context), width: TSizeUtils.wPercent(50, context: context), child: const AnimatedTextColumn()),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 400,
                  width: 400,
                  child: _AboutMeAvatarWidget(),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      tablet: SizedBox(
        height: size.width > 900 ? size.height * 0.5 : size.height * 0.8,
        width: double.maxFinite,
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return NetworkParticle(
                lineStrokeWidth: 0.2,
                maxParticleSize: 4,
                lineColor: context.colorTheme.tertiary.withOpacity(0.4),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                particleColor: context.colorTheme.primary,
                // attractToMouse: true,
                connectDots: true,
                // windEffect: Offset(5, 7),
                isRandomColor: true,
                enableHover: true,
                numberOfParticles: 100,
                gravity: 0,
                interactiveColorChange: true,
              );
            }),
            Column(
              children: [
                size.width <= 900
                    ? const SizedBox(
                        height: 350,
                        width: 350,
                        child: _AboutMeAvatarWidget(),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      // height: 400,
                      width: 400,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: TSizeUtils.hPercent(30, context: context), width: TSizeUtils.wPercent(100, context: context), child: const AnimatedTextColumn()),
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const Spacer(),
                    size.width > 900
                        ? const SizedBox(
                            height: 400,
                            width: 400,
                            child: _AboutMeAvatarWidget(),
                          )
                        : const SizedBox(height: 40),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      mobile: SizedBox(
        height: 700,
        width: double.maxFinite,
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return NetworkParticle(
                lineStrokeWidth: 0.2,
                maxParticleSize: 3,
                lineColor: context.colorTheme.tertiary.withOpacity(0.4),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                particleColor: context.colorTheme.primary,
                // attractToMouse: true,
                connectDots: true,
                // windEffect: Offset(5, 7),
                isRandomColor: true,
                enableHover: true,
                numberOfParticles: 70,
                gravity: 0,
                interactiveColorChange: true,
              );
            }),
            Column(
              children: [
                const SizedBox(height: 330, width: 330, child: _AboutMeAvatarWidget()),
                SizedBox(
                  width: TSizeUtils.wPercent(95, context: context),
                  child: const AnimatedTextColumn(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconLinkButton extends StatelessWidget {
  const _IconLinkButton({required this.icon, required this.url});
  final IconData icon;
  final String url;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // await WebUtils().launchInBrowser(url);
        // await canLaunchUrlString(url);
        TWebUtils.openUrl(url);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: context.colorTheme.surface,
          border: Border.all(style: BorderStyle.solid, color: Colors.green, strokeAlign: BlurEffect.neutralBlur),
          boxShadow: [
            BoxShadow(color: context.colorTheme.inverseSurface, blurRadius: 5),
          ],
        ),
        child: Center(child: FaIcon(icon)),
      ).colorShadowOnHover(),
    );
  }
}

class _AboutMeAvatarWidget extends ConsumerWidget {
  const _AboutMeAvatarWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedRotation(
      duration: const Duration(seconds: 2),
      turns: ref.watch(appThemeModeProvider) == AppThemeMode.dark ? 2 : -2,
      child: Motion(
        shadow: ShadowConfiguration(
          color: context.colorTheme.onPrimaryContainer,
          blurRadius: 25,
        ),
        borderRadius: BorderRadius.circular(200),
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          height: double.maxFinite,
          width: double.maxFinite,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 100,
              ),
            ],
          ),
        ),
      ).flipOnTap(),
    );
  }
}

//todo replace the above widget with the below widget
// class _AboutMeAvatarWidget extends ConsumerWidget {
//   const _AboutMeAvatarWidget();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appTheme = ref.watch(appThemeModeProvider);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final size = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;

//         return AspectRatio(
//           aspectRatio: 1,
//           child: AnimatedRotation(
//             duration: const Duration(seconds: 2),
//             turns: appTheme == AppThemeMode.dark ? 2 : -2,
//             child: Motion(
//               shadow: ShadowConfiguration(
//                 color: context.colorTheme.onPrimaryContainer,
//                 blurRadius: 25,
//               ),
//               borderRadius: BorderRadius.circular(size / 2),
//               child: Container(
//                 margin: EdgeInsets.all(size * 0.1),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.transparent,
//                 ),
//                 child: ClipOval(
//                   child: AnimatedSwitcher(
//                     duration: const Duration(seconds: 2),
//                     transitionBuilder: (Widget child, Animation<double> animation) {
//                       return FadeTransition(
//                         opacity: animation,
//                         child: child,
//                       );
//                     },
//                     child: Image.asset(
//                       appTheme == AppThemeMode.light ? Assets.images.picLight.path : Assets.images.picDark.path,
//                       key: ValueKey(appTheme),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ).flipOnTap(),
//           ),
//         );
//       },
//     );
//   }
// }
class AnimatedTextColumn extends ConsumerStatefulWidget {
  const AnimatedTextColumn({super.key});

  @override
  ConsumerState<AnimatedTextColumn> createState() => _AnimatedTextColumnState();
}

class _AnimatedTextColumnState extends ConsumerState<AnimatedTextColumn> with SingleTickerProviderStateMixin {
  Future<void> delay(int milliseconds) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileView = MediaQuery.of(context).size.width < 400;
    ref.listen(appThemeColorProvider, (previous, next) {
      setState(() {});
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedGreeting(isMobileView),
        _buildAnimatedName(isMobileView),
        _buildAnimatedRole(),
        _buildAnimatedDescription(),
        const SizedBox(height: 30),
        _buildAnimatedIcons(),
      ],
    );
  }

  Widget _buildAnimatedGreeting(bool isMobileView) {
    return FutureBuilder(
      future: delay(0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                'Hii there...',
                textStyle: isMobileView
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: context.colorTheme.secondary,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: context.colorTheme.primary.withOpacity(0.5),
                            offset: const Offset(0, 0),
                          ),
                        ],
                      )
                    : Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: context.colorTheme.secondary,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: context.colorTheme.primary.withOpacity(0.5),
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAnimatedName(bool isMobileView) {
    return FutureBuilder(
      future: delay(1000),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Row(
            children: [
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'I am ',
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: context.colorTheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                    speed: const Duration(milliseconds: 30),
                  ),
                ],
              ),
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    "Srinivasan R",
                    textStyle: isMobileView
                        ? Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: context.colorTheme.primary,
                              fontWeight: FontWeight.bold,
                            )
                        : Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: context.colorTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                    speed: const Duration(milliseconds: 30),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAnimatedRole() {
    return FutureBuilder(
      future: delay(2800),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Row(
            children: [
              const Spacer(flex: 2),
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Ordinary dev',
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: context.colorTheme.tertiary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
              const Spacer(flex: 4),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAnimatedDescription() {
    return FutureBuilder(
      future: delay(3000),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                'Bringing Ideas to Life on iOS, Android, and Beyond with Flutter and Robust Backend Technologies',
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: context.colorTheme.secondary,
                      fontWeight: FontWeight.w500,
                      // color: Colors.green,
                      letterSpacing: 1.2,
                    ),
                speed: const Duration(milliseconds: 15),
              ),
            ],
          ).increaseSizeOnHover(1.01);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAnimatedIcons() {
    return FutureBuilder(
      future: delay(5000),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Spacer(
                        flex: 4,
                      ),
                      _IconLinkButton(
                        icon: FontAwesomeIcons.github,
                        url: "https://github.com/srinivasan0000",
                      ),
                      Spacer(),
                      _IconLinkButton(
                        icon: FontAwesomeIcons.linkedinIn,
                        url: "https://www.linkedin.com/in/srinivasan0000/",
                      ),
                      Spacer(),
                      _IconLinkButton(
                        icon: FontAwesomeIcons.medium,
                        url: "https://medium.com/@srinivasanapprendre",
                      ),
                      Spacer(),
                      _IconLinkButton(
                        icon: FontAwesomeIcons.quora,
                        url: "https://www.quora.com/profile/Srinivasan-R-465?ch=8&oid=1534711570&share=0ea69067&srid=uPLt1w&target_type=user",
                      ),
                      Spacer(),
                      _IconLinkButton(
                        icon: FontAwesomeIcons.telegram,
                        url: "https://t.me/Srinivasan0",
                      ),
                      Spacer(
                        flex: 4,
                      ),
                    ]),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
