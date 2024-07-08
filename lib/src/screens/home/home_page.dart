import 'dart:math' as math;
import 'dart:ui';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/extensions/hover_extensions.dart';
import '../../core/extensions/material_extensions.dart';
import '../../services/app_theme.dart';
import '../../widgets/expandable_fab_widget.dart';
import '../../widgets/mouse_follower_widget/mouse_style_stacks.dart';
import '../../widgets/mouse_follower_widget/mouse_style_widget.dart';
import '../../widgets/responsive_widget.dart';
import '../../widgets/spinning_sphere.dart';
import 'sections/about_me_section.dart';
import 'sections/certifications_section.dart';
import 'sections/contact_info_section.dart';
import 'sections/intro_section.dart';
import 'sections/projects_section.dart';
import 'sections/sim_section.dart';
import 'sections/skills_section.dart';

part 'home_widgets.dart';

final Map<String, GlobalKey<State<StatefulWidget>>> sectionKeys = {
  HomeSections.intro.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.skills.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.aboutMe.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.projects.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.bored.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.certifications.name: GlobalKey<State<StatefulWidget>>(),
  HomeSections.contact.name: GlobalKey<State<StatefulWidget>>(),
};

enum HomeSections { intro, skills, aboutMe, projects, bored, certifications, contact }

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<bool> _isVisibleList = List.filled(HomeSections.values.length, false);
  late ScrollController _controller;
  bool _isHoveringFab = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final shouldShowDialog = ref.watch(dateDiffProvider);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (size.width < 600 && shouldShowDialog) {
    //     showTryWebDialog(context);
    //   }
    // });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFAB(size, context),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: _GlowingGradientAppBar(
        child: AppBar(
          backgroundColor: context.colorTheme.primary.withOpacity(0.1),
          title: size.width > 500
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 150,
                      child: Text("Mobile View in Development", style: Theme.of(context).textTheme.bodySmall))),
          centerTitle: false,
          actions: [
            size.width > 600
                ? const MouseOnHoverEvent(
                    onHoverMouseCursor: SystemMouseCursors.contextMenu,
                    size: Size(50, 50),
                    child: SizedBox(
                      height: 40,
                      width: 100,
                    ),
                  )
                : const SizedBox(),
            _buildAppBarActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarActions(BuildContext context) {
    return ResponsiveWidget(
      desktop: Row(children: [
        ..._buildSectionButtons(),
        _buildDivider(context),
        _buildColorPicker(context),
        _buildThemeToggle(),
      ]),
      mobile: Row(
        children: [
          ..._buildSectionButtons().take(2),
          // ..._buildSectionButtons().reversed.take(2),
          _buildDivider(context),
          _buildColorPicker(context),
          _buildThemeToggle(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      cacheExtent: 2000,
      controller: _controller,
      itemCount: HomeSections.values.length,
      itemBuilder: (BuildContext context, int index) {
        return VisibilityDetector(
          key: Key('item-$index'),
          onVisibilityChanged: (info) => _handleVisibilityChanged(info, index),
          child: _buildAnimatedSection(index),
        );
      },
    );
  }

  Widget _buildFAB(Size size, BuildContext context) {
    return MouseRegion(
      onHover: (_) => setState(() => _isHoveringFab = true),
      onExit: (_) => setState(() => _isHoveringFab = false),
      child: SizedBox(
        height: size.width > 500 ? 200 : 100,
        width: size.width > 500 ? 200 : 100,
        child: _isHoveringFab ? _buildExpandableFab(context) : null,
      ),
    );
  }

  void _handleVisibilityChanged(VisibilityInfo info, int index) {
    if (info.visibleFraction > 0.05) {
      _setVisibility(index, true);
    } else {
      _setVisibility(index, false);
    }
  }

  void _setVisibility(int index, bool isVisible) {
    Future.delayed(Duration(milliseconds: isVisible ? 0 : 100), () {
      if (mounted) {
        setState(() => _isVisibleList[index] = isVisible);
      }
    });
  }

  void _changeColor(Color color) {
    ref.read(appThemeColorProvider.notifier).changeColor(color.value);
  }

  List<Widget> _buildSectionButtons() {
    return HomeSections.values
        .asMap()
        .entries
        .map(
          (entry) => _buildActionButton(entry.value.name, entry.key),
        )
        .toList();
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: double.maxFinite,
      margin: const EdgeInsets.all(5),
      width: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: context.colorTheme.primary,
      ),
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () => _colorPickerDialog(context),
        child: _buildRotatingSpinningSphere(context),
      ),
    );
  }

  Widget _buildRotatingSpinningSphere(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      turns: ref.watch(appThemeModeProvider) == AppThemeMode.dark ? 2 : -2,
      child: SpinningSphere(
        color1: context.colorTheme.primary,
        color2: context.colorTheme.tertiaryContainer,
        size: 50,
      ).zoomOnHover(scale: 1.1),
    );
  }

  Widget _buildThemeToggle() {
    return AnimatedRotation(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      turns: ref.watch(appThemeModeProvider) == AppThemeMode.dark ? 2 : -2,
      child: IconButton(
        onPressed: () => ref.read(appThemeModeProvider.notifier).toggleTheme(),
        icon: Icon(ref.watch(appThemeModeProvider) == AppThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
      ),
    );
  }

  Widget _buildExpandableFab(BuildContext context) {
    return ExpandableFab(
      backgroundColor: context.colorTheme.tertiary,
      openIcon: Icons.ads_click,
      distance: 112,
      children: [
        for (var i = 0; i < 5; i++)
          ActionButton(
            onPressed: () =>
                ref.read(appMouseStackStyleProvider.notifier).changeMouseStyleStack(AppMouseStyleStack.values[i]),
            icon: Icon(_getIconForStack(i)),
          ),
      ],
    );
  }

  IconData _getIconForStack(int index) {
    switch (index) {
      case 0:
        return Icons.more_horiz;
      case 1:
        return Icons.hdr_strong;
      case 2:
        return Icons.scatter_plot;
      case 3:
        return Icons.category;
      case 4:
        return Icons.change_history;
      default:
        return Icons.error;
    }
  }

  void showTryWebDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.computer,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                "Desktop Experience",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Open this website on a desktop for a better experience!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Okay",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String sectionName, int index) {
    final isActive = _isVisibleList.indexWhere((element) => element == true) == index;
    final hoverNotifier = ValueNotifier<bool>(false);

    return _isVisibleList[index] != true
        ? MouseRegion(
            onEnter: (_) => hoverNotifier.value = true,
            onExit: (_) => hoverNotifier.value = false,
            child: AnimatedBuilder(
              animation: hoverNotifier,
              builder: (context, child) {
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: hoverNotifier.value || isActive ? 1 : 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 1 + (0.05 * value),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color.lerp(Colors.transparent, Theme.of(context).primaryColor.withOpacity(0.1), value),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(0.1 * value),
                              blurRadius: 10 * value,
                              spreadRadius: 2 * value,
                            ),
                          ],
                          border: Border.all(
                            color: Color.lerp(Colors.transparent, Theme.of(context).primaryColor, value)!,
                            width: 1.5,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Scrollable.ensureVisible(
                              sectionKeys[sectionName]!.currentContext!,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOut,
                              alignment: 0.3,
                            );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.lerp(Colors.transparent, Theme.of(context).primaryColor, value),
                                ),
                                child: Center(
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0, end: value),
                                    duration: const Duration(milliseconds: 300),
                                    builder: (context, value, child) {
                                      return Transform.rotate(
                                        angle: value * 2 * 3.14159,
                                        child: Icon(
                                          isActive ? Icons.check : Icons.arrow_forward,
                                          size: 12 * value,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  fontSize: 16 + (2 * value),
                                  fontWeight: FontWeight.lerp(FontWeight.normal, FontWeight.bold, value),
                                  color: Color.lerp(
                                      Theme.of(context).textTheme.titleSmall!.color, context.colorTheme.primary, value),
                                ),
                                child: Text(sectionName.capitalizeIt()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        : const SizedBox();
  }

  Future<void> _colorPickerDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
                child: SizedBox(
              width: 300,
              child: ColorPicker(
                actionButtons: const ColorPickerActionButtons(visualDensity: VisualDensity.compact),
                // enableOpacity: true,
                width: 44,
                height: 44,
                borderRadius: 22,
                heading: Text(
                  'Select color',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subheading: Text(
                  'Select color shade',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                onColorChanged: _changeColor,
                color: Color(ref.watch(appThemeColorProvider)),
              ),
            )));
      },
    );
  }

  Widget _buildAnimatedSection(int index) {
    const duration = Duration(milliseconds: 1000);
    const curve = Curves.easeInOut;

    switch (index) {
      case 0:
        return AnimatedOpacity(
          duration: duration,
          opacity: _isVisibleList[index] ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: duration,
            offset: Offset(0, _isVisibleList[index] ? 0 : 0.5),
            child: IntroSection(key: sectionKeys[HomeSections.intro.name]!),
          ),
        );

      case 1:
        return AnimatedScale(
          scale: _isVisibleList[index] ? 1.0 : 0.8,
          duration: duration,
          curve: curve,
          child: AnimatedRotation(
            turns: _isVisibleList[index] ? 0 : 0.1,
            duration: duration,
            curve: curve,
            child: SkillsSection(key: sectionKeys[HomeSections.skills.name]!),
          ),
        );
      case 2:
        return AnimatedScale(
          duration: duration,
          scale: _isVisibleList[index] ? 1.0 : 0.8,
          curve: curve,
          child: AnimatedOpacity(
            duration: duration,
            opacity: _isVisibleList[index] ? 1.0 : 0.0,
            child: AboutMeSection(key: sectionKeys[HomeSections.aboutMe.name]!),
          ),
        );
      case 3:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _isVisibleList[index] ? const AlwaysStoppedAnimation(1.0) : const AlwaysStoppedAnimation(0.0),
              curve: curve,
            ),
          ),
          child: AnimatedOpacity(
            duration: duration,
            opacity: _isVisibleList[index] ? 1.0 : 0.0,
            child: MyProjectSection(key: sectionKeys[HomeSections.projects.name]!),
          ),
        );
      case 4:
        return AnimatedOpacity(
          duration: duration,
          opacity: _isVisibleList[index] ? 1.0 : 0.0,
          child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.only(right: _isVisibleList[index] ? 0 : 100),
            child: AnimatedScale(
              duration: duration,
              scale: _isVisibleList[index] ? 1.0 : 0.8,
              child: SimSection(key: sectionKeys[HomeSections.bored.name]!),
            ),
          ),
        );
      case 5:
        return AnimatedOpacity(
          duration: duration,
          opacity: _isVisibleList[index] ? 1.0 : 0.0,
          child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.only(left: _isVisibleList[index] ? 0 : 100),
            child: AnimatedSlide(
              duration: duration,
              offset: Offset(_isVisibleList[index] ? 0 : 0.5, 0),
              child: CertificationsSection(key: sectionKeys[HomeSections.certifications.name]!),
            ),
          ),
        );
      case 6:
        return AnimatedOpacity(
          duration: duration,
          opacity: _isVisibleList[index] ? 1.0 : 0.0,
          child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.only(left: _isVisibleList[index] ? 0 : 100),
            child: AnimatedScale(
              duration: duration,
              scale: _isVisibleList[index] ? 1.0 : 0.9,
              child: ContactInfoSection(key: sectionKeys[HomeSections.contact.name]!),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
