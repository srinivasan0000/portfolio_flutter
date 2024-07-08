import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/extensions/hover_extensions.dart';
import '../../../core/extensions/material_extensions.dart';
import '../home_page.dart';
import '../../../widgets/heartbeat_widget.dart';
import '../../../widgets/responsive_widget.dart';
import '../../../core/utils/web_utils.dart';
import '../../../widgets/background_gradiant.dart';

class ContactInfoSection extends ConsumerWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveWidget(
      desktop: _DesktopLayout(),
      mobile: _MobileLayout(),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackgroundGradientAnimation(
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colorTheme.surfaceContainerHighest.withOpacity(0.92),
                  context.colorTheme.surfaceContainerHigh.withOpacity(0.92),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _Infoandmessage()),
                      Expanded(child: _QuickLinks()),
                      Expanded(child: _ContactInfo()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _FooterBar(),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundGradientAnimation(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colorTheme.surfaceContainerHighest.withOpacity(0.9),
              context.colorTheme.surfaceContainerHigh.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            _Infoandmessage(),
            _AnimatedDivider(),
            _QuickLinks(),
            _AnimatedDivider(),
            _ContactInfo(),
            _FooterBar(),
          ],
        ),
      ),
    );
  }
}

class _AnimatedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Divider(
          endIndent: 10 * (1 - value),
          indent: 10 * (1 - value),
          thickness: 2,
          color: context.colorTheme.primary.withOpacity(value),
        );
      },
    );
  }
}

class _FooterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      color: context.colorTheme.surfaceContainerLowest.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            "Made with ",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const HeartbeatWidget(
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ).zoomOnHover(),
          AutoSizeText(
            " using Flutter Web",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Info",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: context.colorTheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          const _ContactInfoRow(icon: Icons.mail, text: "Sri******@gmail.com"),
          const _ContactInfoRow(icon: FontAwesomeIcons.mapLocation, text: "Porur, Chennai, India"),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _LinkCard(icon: FontAwesomeIcons.linkedin, url: "https://www.linkedin.com/in/srinivasan0000/"),
              _LinkCard(icon: FontAwesomeIcons.github, url: "https://github.com/srinivasan0000"),
              _LinkCard(icon: FontAwesomeIcons.medium, url: "https://medium.com/@srinivasanapprendre"),
              _LinkCard(icon: FontAwesomeIcons.quora, url: "https://www.quora.com/profile/Srinivasan-R-465?ch=8&oid=1534711570&share=0ea69067&srid=uPLt1w&target_type=user"),
              _LinkCard(icon: FontAwesomeIcons.telegram, url: "https://t.me/Srinivasan0"),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colorTheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  const _LinkCard({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => TWebUtils.openUrl(url),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FaIcon(icon, color: context.colorTheme.primary),
        ),
      ),
    ).zoomOnHover();
  }
}

class _QuickLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Links",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: context.colorTheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          _QuickLinkButton(
            text: "Home",
            icon: Icons.home,
            onPressed: () {
              Scrollable.ensureVisible(
                sectionKeys[HomeSections.intro.name]!.currentContext!,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                alignment: 0.3,
              );
            },
          ),
          _QuickLinkButton(
            text: "Skills",
            icon: Icons.build,
            onPressed: () {
              Scrollable.ensureVisible(
                sectionKeys[HomeSections.skills.name]!.currentContext!,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                alignment: 0.3,
              );
            },
          ),
          _QuickLinkButton(
            text: "About Me",
            icon: Icons.person,
            onPressed: () {
              Scrollable.ensureVisible(
                sectionKeys[HomeSections.aboutMe.name]!.currentContext!,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                alignment: 0.3,
              );
            },
          ),
          _QuickLinkButton(
            text: "Projects",
            icon: Icons.work,
            onPressed: () {
              Scrollable.ensureVisible(
                sectionKeys[HomeSections.projects.name]!.currentContext!,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                alignment: 0.3,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickLinkButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;
  const _QuickLinkButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: context.colorTheme.primary),
        label: Text(text, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

class _Infoandmessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Srinivasan R",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: context.colorTheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            "An Ordinary Developer Portfolio",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontStyle: FontStyle.italic,
                  color: context.colorTheme.secondary,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            "Thank you for visiting my portfolio. Feel free to contact me!",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                SnackBar snackBar = SnackBar(
                  elevation: 0,

                  backgroundColor: Colors.transparent,
                  content: Row(
                    children: [
                      const Spacer(),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.colorTheme.primary.withOpacity(0.7),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: const Center(child: Text('Flutter : 3.22.2   Dart 3.4.3'))),
                      const Spacer()
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  // width: 200,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.code, color: context.colorTheme.primary),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          "Made with ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const HeartbeatWidget(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        ).zoomOnHover(scale: 1.05),
                        Text(
                          " using Flutter Web",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
