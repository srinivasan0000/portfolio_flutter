import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/material_extensions.dart';
import '../../../services/app_theme.dart';
import '../../../widgets/petal_widget.dart';
import '../../../widgets/responsive_widget.dart';

import '../../../widgets/time_line_widget.dart';

import 'package:flutter_animate/flutter_animate.dart';

class AboutMeSection extends ConsumerStatefulWidget {
  const AboutMeSection({super.key});

  @override
  ConsumerState<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends ConsumerState<AboutMeSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: ref.read(tabBarAnimateProvider));
  }

  final entries = [
    TimelineEntry(fromDate: DateTime(2022, 2), toDate: DateTime(2022, 5), title: "Role 1", description: "Description for this tile", icon: Icons.event),
    TimelineEntry(fromDate: DateTime(2022, 6), toDate: DateTime(2022, 9), title: "Role 2", description: "Description for this tile", icon: Icons.event),
    TimelineEntry(fromDate: DateTime(2022, 9), toDate: DateTime.now(), title: "Role 3", description: "Description for this tile", icon: Icons.event)
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: _buildDesktopLayout(),
      mobile: _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 500,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorTheme.primaryContainer.withOpacity(0.1),
              context.colorTheme.tertiaryContainer.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildTabBarView(),
                  ),
                  Expanded(
                    child: _buildAnimatedPetal(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 850,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorTheme.primaryContainer.withOpacity(0.1),
              context.colorTheme.tertiaryContainer.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _buildAnimatedPetal(mobile: true),
            _buildTabBar(mobile: true),
            Expanded(
              child: _buildTabBarView(mobile: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar({bool mobile = false}) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      controller: _tabController,
      onTap: (value) {
        ref.read(tabBarAnimateProvider.notifier).update((state) => value);
      },
      indicatorWeight: 3,
      indicatorColor: context.colorTheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      labelColor: context.colorTheme.primary,
      unselectedLabelColor: context.colorTheme.onSurface.withOpacity(0.7),
      tabs: [
        _buildTab('About Me', mobile),
        _buildTab('As a Flutter Developer', mobile),
        _buildTab('Experience', mobile),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildTab(String text, bool mobile) {
    return _AnimatedTab(text: text, mobile: mobile);
  }

  Widget _buildTabBarView({bool mobile = false}) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildAboutMeTab(mobile),
        _buildFlutterDevTab(mobile),
        _buildExperienceTab(mobile),
      ],
    );
  }

  Widget _buildAboutMeTab(bool mobile) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('About Me'),
            const SizedBox(height: 20),
            _buildAboutMeContent(mobile),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildFlutterDevTab(bool mobile) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('As a Flutter Developer'),
            const SizedBox(height: 20),
            _buildFlutterDevContent(mobile),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildExperienceTab(bool mobile) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Experience'),
          const SizedBox(height: 20),
          Expanded(
            child: TimelineWidget(
              entries: entries,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: context.colorTheme.primary,
            fontWeight: FontWeight.bold,
          ),
    ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildAboutMeContent(bool mobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          """I am a software developer specializing in Flutter, with around two years of experience in Flutter development. In addition, I have hands-on expertise with various technologies, including ASP.NET Core, SQL, and Azure. I am a Microsoft AZ-204 certified Azure Developer Associate. I am proficient in mobile application development and possess hands-on experience in backend and cloud services.

I have worked on various production-grade projects, where I design project architecture, structure, and patterns based on specific requirements. I have also led teams, promoting best practices and assisting in project development by suggesting new features and implementations in collaboration with managers.
""",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        _buildSkillItem('Flutter Developer', 'Developed and maintained production-grade applications using Flutter, ensuring high performance and responsiveness.'),
        _buildSkillItem('ASP.NET Core and SQL', 'Hands-on experience with ASP.NET Core Web API, Postgresql and SQL Server, focusing on backend development and API integration.'),
        _buildSkillItem('Cloud', 'Microsoft AZ-204 certified, with practical experience in cloud services.'),
      ],
    );
  }

  Widget _buildFlutterDevContent(bool mobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _KtextSkillWidget(text: "Proficient in developing scalable, maintainable, and robust mobile and web applications with a focus on high performance and reliability."),
        const _KtextSkillWidget(
            text:
                "Experienced in implementing advanced state management solutions like Riverpod, Bloc, Provider, and GetX to efficiently handle complex app states, prioritizing Riverpod for building high-quality applications."),
        const _KtextSkillWidget(text: "Skilled in integrating RESTful APIs, implementing data caching strategies, and managing asynchronous states effectively on a daily basis."),
        const _KtextSkillWidget(
            text:
                "Adheres to best practices including code modularization, rigorous code review processes, version control (Git), configuring lint rules, and continuous integration/delivery (CI/CD)."),
        const _KtextSkillWidget(
            text:
                "Proficient in developing responsive layouts, subtle animations, and pixel-perfect designs following Material Design and Cupertino guidelines to enhance user experience and fluidity."),
        const _KtextSkillWidget(text: "Experienced in writing unit tests and widget using Flutter testing frameworks to ensure code quality, reliability, and maintainability."),
        const _KtextSkillWidget(
            text: "Experienced in optimizing app performance for speed, responsiveness, and efficiency, including memory management, network caching, and minimizing app size."),
        const _KtextSkillWidget(text: "Capable of integrating native code into Flutter projects for enhanced functionality."),
        const SizedBox(height: 20),
        _buildSkillsSection(mobile),
      ],
    );
  }

  Widget _buildSkillsSection(bool mobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Skills in Flutter", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        _buildSkillItem('State Management', 'Riverpod, Bloc, Provider, GetX'),
        _buildSkillItem('API Integration', 'RESTful APIs, Dio, Http, Chopper'),
        _buildSkillItem('Local Db', 'SQLite, Hive, Isar, shared preferences'),
        _buildSkillItem('Route Management', 'GoRouter, AutoRoute'),
        _buildSkillItem('Gen', 'Freezed, json serializable, Riverpod generator, Assets gen'),
        _buildSkillItem('UI', 'Material & Cupertino design, Responsive Layouts, Animations'),
      ],
    );
  }

  Widget _buildSkillItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: context.colorTheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: context.colorTheme.onSurface),
                  ),
                  TextSpan(
                    text: description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: context.colorTheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildAnimatedPetal({bool mobile = false}) {
    return Container(
      height: mobile ? 250 : double.infinity,
      width: mobile ? double.infinity : null,
      color: context.colorTheme.surface,
      child: AnimatedRotation(
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        turns: ref.watch(appThemeModeProvider) == AppThemeMode.dark ? 2 : -2,
        child: Transform.scale(
          scale: 1.2,
          child: const PetalWidget(rotationDuration: Duration(milliseconds: 10000)),
        ),
      ),
    );
    // .animate().fadeIn(duration: 800.ms, delay: 200.ms).scale(begin: Offset(0.8, 0), end: Offset(1.0, 0));
  }
}

class _KtextSkillWidget extends StatelessWidget {
  const _KtextSkillWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          constraints: const BoxConstraints(maxHeight: 100, minHeight: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 20,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: context.colorTheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      mobile: Container(
        margin: const EdgeInsets.only(bottom: 5),
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideY(begin: 0.2, end: 0);
  }
}

class _AnimatedTab extends StatefulWidget {
  final String text;
  final bool mobile;

  const _AnimatedTab({required this.text, required this.mobile});

  @override
  _AnimatedTabState createState() => _AnimatedTabState();
}

class _AnimatedTabState extends State<_AnimatedTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _isHovered ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
              ),
              child: Text(
                widget.text,
                style: widget.mobile
                    ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        )
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}
