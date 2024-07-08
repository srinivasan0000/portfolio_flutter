import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/network_images.dart';
import '../../../core/extensions/design_extensions.dart';
import '../../../core/extensions/hover_extensions.dart';
import '../../../core/extensions/material_extensions.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../widgets/mouse_network_line_widget.dart';
import '../../../widgets/responsive_widget.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    double responsiveHeight = size.width > 1400
        ? 400
        : size.width > 1200
            ? 350
            : size.width > 800
                ? 400
                : size.width > 500
                    ? 450
                    : 500;
    return Container(
        height: responsiveHeight,
        width: size.width,
        color: context.colorTheme.surface,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              ResponsiveWidget(
                desktop: TabBar(
                    indicatorColor: context.colorTheme.primary,
                    // indicator: BoxDecoration(
                    //   color: context.colorTheme.primary,
                    //   backgroundBlendMode: BlendMode.difference,
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    // isScrollable: true,
                    tabs: [
                      Tab(child: Text("Software Skills", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600))).withGradiant().moveUpOnHover,
                      Tab(child: Text("Flutter Skills", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600))).withGradiant().moveUpOnHover,
                      Tab(child: Text("Other Skills", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600))).withGradiant().moveUpOnHover,
                    ]),
                mobile: Row(
                  children: [
                    SizedBox(
                      width: size.width,
                      child: TabBar(isScrollable: false, tabs: [
                        Tab(child: Text("Software Skills", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500))).withGradiant().moveUpOnHover,
                        Tab(child: Text("Flutter Skills", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500))).withGradiant().moveUpOnHover,
                        Tab(child: Text("Other Skills", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500))).withGradiant().moveUpOnHover,
                      ]),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: _SkillsListWidget(
                        children: [
                          const _SkillCard(skillName: 'Flutter', count: 3, image: SkillImages.flutter),
                          const _SkillCard(skillName: 'Dart', count: 3, image: SkillImages.dart),
                          _SkillCard(skillName: "Asp.Net Core", count: 2, image: Assets.icons.nETCore.path, isAssetImage: true),
                          const _SkillCard(skillName: 'Firebase', count: 2, image: SkillImages.firebase),
                          const _SkillCard(skillName: "SQL", count: 2, image: SkillImages.sql),
                          const _SkillCard(skillName: "C#", count: 2, image: SkillImages.csharp),
                          const _SkillCard(skillName: "PostgreSQL", count: 2, image: SkillImages.postgresql),
                          const _SkillCard(skillName: "Azure", count: 2, image: SkillImages.azure),
                          const _SkillCard(skillName: "Azure DevOps", count: 1, image: SkillImages.azureDevOps),
                          const _SkillCard(skillName: "Go Lang", count: 2, image: SkillImages.golang),
                          const _SkillCard(skillName: "Kotlin", count: 2, image: SkillImages.kotlin),
                          const _SkillCard(skillName: "Swift", count: 2, image: SkillImages.swift),
                          const _SkillCard(skillName: "Git", count: 3, image: SkillImages.git),
                          const _SkillCard(skillName: "Docker", count: 1, image: SkillImages.docker),
                          const _SkillCard(skillName: "Java", count: 1, image: SkillImages.java),
                          const _SkillCard(skillName: "Python", count: 1, image: SkillImages.python),
                          const _SkillCard(skillName: "MySql", count: 1, image: SkillImages.mysql),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: _SkillsListWidget(
                        children: [
                          const _SkillCard(skillName: 'Flutter', image: SkillImages.flutter),
                          const _SkillCard(skillName: 'Dart', image: SkillImages.dart),
                          _SkillCard(skillName: 'Riverpod', image: Assets.icons.riverpod.path, isAssetImage: true),
                          const _SkillCard(skillName: "Hive", count: 1, image: SkillImages.hive),
                          const _SkillCard(
                            skillName: "SqfLite",
                            count: 2,
                            image: SkillImages.sqfLite,
                          ),
                          _SkillCard(skillName: "BLoC", count: 3, image: Assets.icons.bloc.path, isAssetImage: true),
                          const _SkillCard(skillName: "Getx", count: 1, image: SkillImages.getx),
                          const _SkillCard(skillName: "Provider", count: 2, image: SkillImages.flutter1),
                          const _SkillCard(skillName: "GoRouter", count: 3, image: SkillImages.flutter3),
                          const _SkillCard(skillName: "AutoRoute", count: 1, image: SkillImages.flutter4),
                          const _SkillCard(skillName: "Isar", count: 2, image: SkillImages.isar),
                          const _SkillCard(skillName: "Firebase", count: 1, image: SkillImages.firebase),
                          _SkillCard(skillName: "FVM", count: 1, image: Assets.icons.fvm.path, isAssetImage: true),
                          _SkillCard(skillName: "FastLane", count: 2, image: Assets.icons.fastlane.path, isAssetImage: true),
                          const _SkillCard(skillName: "RxDart", count: 2, image: SkillImages.rxdart),
                          const _SkillCard(skillName: "Mockito", count: 2, image: SkillImages.flutter2),
                          _SkillCard(skillName: "Dio", count: 3, image: Assets.icons.dio.path, isAssetImage: true),
                          const _SkillCard(skillName: "GetIt", count: 2, image: SkillImages.flutter5),
                        ],
                      ),
                    ),
                    _SkillsListWidget(
                      children: [
                        const _SkillCard(skillName: 'Excel', image: SkillImages.excel),
                        const _SkillCard(skillName: 'Tableau', image: SkillImages.tableau),
                        _SkillCard(skillName: 'Catia V5', image: Assets.icons.catia.path, isAssetImage: true),
                        _SkillCard(skillName: "Solid Works", image: Assets.icons.solidworks.path, isAssetImage: true),
                        const _SkillCard(skillName: "Photoshop", count: 2, image: SkillImages.photoshop),
                        const _SkillCard(skillName: "After Effects", count: 3, image: SkillImages.afterEffects),
                        const _SkillCard(skillName: "Premiere Pro", count: 1, image: SkillImages.premierpro),
                        const _SkillCard(skillName: "Word", count: 2, image: SkillImages.word),
                        _SkillCard(skillName: "Networking", count: 3, image: Assets.icons.networking.path, isAssetImage: true),
                        _SkillCard(skillName: "Certified Eqity Derivatives", count: 1, image: Assets.icons.nISMCertificate.path, isAssetImage: true),
                        _SkillCard(skillName: "Certified Research Analyst", count: 2, image: Assets.icons.nISMCertificate.path, isAssetImage: true),
                        const _SkillCard(skillName: "UAV Design", count: 1, image: SkillImages.uav),
                        _SkillCard(skillName: "Maya 3ds Max", count: 3, image: Assets.icons.maya.path, isAssetImage: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _SkillsListWidget extends StatelessWidget {
  const _SkillsListWidget({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return MouseNetworkLineWidget(
      pointFromY: 35,
      children: children,
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({
    required this.skillName,
    required this.image,
    this.count = 0,
    this.isAssetImage = false,
  }) : assert(count <= 3, 'Count must be less than or equal to 3');

  final String skillName;
  final String image;
  final int count;
  final bool isAssetImage;

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveWidget(
      desktop: _buildDesktopCard(size),
      tablet: _buildTabletCard(size),
      mobile: _buildMobileCard(),
    );
  }

  Widget _buildDesktopCard(Size size) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              elevation: _isHovered ? 15 : 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.08,
                decoration: BoxDecoration(
                  color: context.colorTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: context.colorTheme.primary.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: _buildCardContent(isDesktop: true),
              ),
            ),
          );
        },
      ),
    );
    // .animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildTabletCard(Size size) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.1,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildCardContent(isDesktop: false),
      ),
    ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildMobileCard() {
    return Transform.scale(
      scale: 0.8,
      child: Card(
        margin: const EdgeInsets.only(top: 2, bottom: 2, left: 5),
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 80,
          width: 100,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: context.colorTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _buildCardContent(isDesktop: false, isMobile: true),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildCardContent({required bool isDesktop, bool isMobile = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildImage(isDesktop: isDesktop, isMobile: isMobile),
        _buildSkillName(isMobile: isMobile),
        _buildSkillLevel(isDesktop: isDesktop, isMobile: isMobile),
      ],
    );
  }

  Widget _buildImage({required bool isDesktop, bool isMobile = false}) {
    double size = isDesktop ? 55 : (isMobile ? 40 : 50);
    return SizedBox(
      height: size,
      width: size,
      child: widget.isAssetImage ? Image.asset(widget.image) : Image.network(widget.image, fit: BoxFit.fill),
    ).animate().shimmer(duration: 1.seconds, delay: 500.ms);
  }

  Widget _buildSkillName({bool isMobile = false}) {
    return Flexible(
      child: AutoSizeText(
        widget.skillName,
        textAlign: TextAlign.center,
        style: isMobile ? Theme.of(context).textTheme.bodySmall : null,
      ),
    );
  }

  Widget _buildSkillLevel({required bool isDesktop, bool isMobile = false}) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 8 : (isMobile ? 3 : 5),
            vertical: isDesktop ? 3 : (isMobile ? 1 : 2),
          ),
          child: Row(
            children: List.generate(
              widget.count,
              (index) => Container(
                height: 3,
                width: 3,
                decoration: BoxDecoration(
                  color: context.colorTheme.tertiary,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(left: 5),
              ).animate().scale(delay: (index * 100).ms, duration: 300.ms),
            ),
          ),
        ),
      ],
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

final mouserHoverShiftProvider = StateProvider<bool>((ref) {
  return false;
});

class MouseHoverShift extends ConsumerWidget {
  const MouseHoverShift({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      onHover: (event) {
        ref.read(mouserHoverShiftProvider.notifier).state = true;
      },
      onExit: (event) {
        ref.read(mouserHoverShiftProvider.notifier).state = false;
      },
      child: child,
    );
  }
}
