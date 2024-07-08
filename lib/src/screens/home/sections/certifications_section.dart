import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/material_extensions.dart';
import '../../../widgets/onhover_widgets.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../widgets/responsive_widget.dart';
import '../../../widgets/three_dimensional_card_widget.dart';

class CertificationsSection extends ConsumerStatefulWidget {
  const CertificationsSection({super.key});

  @override
  ConsumerState<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends ConsumerState<CertificationsSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktop: _buildDesktop(context),
      tablet: _buildTablet(context),
      mobile: _buildMobile(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
            height: 320,
            child: ZoomSlider(
              seconds: 5,
              viewPort: 0.4,
              child: _buildCertificates(context, isDesktop: true),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTablet(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ZoomSlider(
        seconds: 5,
        viewPort: 0.6,
        child: _buildCertificates(context),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 450 ? _buildMobileWide(context) : _buildMobileNarrow(context);
  }

  Widget _buildMobileWide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 320,
        child: ZoomSlider(
          radius: 20,
          seconds: 3,
          viewPort: 0.6,
          child: _buildCertificates(context, isMobile: true),
        ),
      ),
    );
  }

  Widget _buildMobileNarrow(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Transform.scale(
        scale: 1.7,
        child: ZoomSlider(
          radius: 5,
          seconds: 3,
          viewPort: 0.4,
          child: _buildCertificates(context, isMobile: true, isNarrow: true),
        ),
      ),
    );
  }

  List<Widget> _buildCertificates(BuildContext context, {bool isDesktop = false, bool isMobile = false, bool isNarrow = false}) {
    final certificates = [
      CertificateData(
        logo: Assets.certifications.playAcademyLogo.path,
        image: Assets.certifications.playAcademy.path,
        title: 'Google Play Academy',
        description: 'I obtained the Google Play Academy Certificate, learning how to deploy an app on the Play Store and use the Google Play Console.',
      ),
      CertificateData(
        logo: Assets.certifications.playAcademyLogo.path,
        image: Assets.certifications.playAcademy.path,
        title: 'Azure AZ-204',
        description: 'Certified Azure Developer Associate, proficient in developing solutions for Microsoft Azure.',
      ),
    ];

    return certificates.map((cert) => _buildCertificateCard(context, cert, isDesktop: isDesktop, isMobile: isMobile, isNarrow: isNarrow)).toList();
  }

  Widget _buildCertificateCard(BuildContext context, CertificateData cert, {bool isDesktop = false, bool isMobile = false, bool isNarrow = false}) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return ThreeDimensionalCard(
      cardColor: context.colorTheme.surfaceContainerLowest,
      width: isNarrow
          ? 250
          : (isMobile
              ? 300
              : (isDesktop
                  ? 500
                  : size.width < 950
                      ? 300
                      : 400)),
      height: isNarrow ? 180 : (isMobile ? 200 : (isDesktop ? 310 : 250)),
      child: FadedTextOnHover(
        hoverText: cert.description,
        fontSize: isNarrow ? 12 : (isMobile ? 15 : 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isNarrow
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(cert.logo, height: isMobile ? 50 : 100, width: isMobile ? 50 : 100),
                      ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.colorTheme.tertiaryFixedDim,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          cert.image,
                          fit: BoxFit.cover,
                          height: isNarrow ? 120 : (isMobile ? 180 : 220),
                          // width: isNarrow ? 150 : (isMobile ? 230 : 300),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            _buildCardFooter(theme, cert.title, isMobile, isNarrow),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFooter(ThemeData theme, String title, bool isMobile, bool isNarrow) {
    return Container(
      alignment: Alignment.center,
      height: isNarrow ? 20 : (isMobile ? 30 : 50),
      color: theme.primaryColor,
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: isNarrow ? 14 : (isMobile ? 15 : 20),
        ),
      ),
    );
  }
}

final class CertificateData {
  final String logo;
  final String image;
  final String title;
  final String description;

  CertificateData({required this.logo, required this.image, required this.title, required this.description});
}

class ZoomSlider extends StatefulWidget {
  const ZoomSlider({super.key, required this.child, this.seconds = 2, this.zoomFactor = 10, this.viewPort = 0.4, this.radius = 0});

  final List<Widget> child;
  final double radius;
  final int seconds;
  final double viewPort;
  final double zoomFactor;

  @override
  State<ZoomSlider> createState() => _ZoomSliderState();
}

class _ZoomSliderState extends State<ZoomSlider> {
  double _currentPage = 0.0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: widget.viewPort,
    );

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
        if (_currentPage >= widget.child.length + 1) {
          _currentPage = 1;
          _pageController.jumpToPage(_currentPage.toInt());
        } else if (_currentPage <= 0) {
          _currentPage = widget.child.length.toDouble();
          _pageController.jumpToPage(_currentPage.toInt());
        }
      });
    });
    startTimer();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    if (widget.seconds > 0) {
      _timer = Timer.periodic(Duration(seconds: widget.seconds), (timer) {
        setState(() {
          _currentPage++;

          if (_currentPage >= widget.child.length + 1) {
            _currentPage = 1;
            _pageController.jumpToPage(_currentPage.toInt());
          } else {
            _pageController.animateToPage(_currentPage.toInt(), duration: const Duration(milliseconds: 500), curve: Curves.linear);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.child.length + 2,
      itemBuilder: (context, index) {
        int actualIndex = (index - 1 + widget.child.length) % widget.child.length;

        double scaleFactor = 1.0 - ((_currentPage - index).abs() * widget.zoomFactor);

        scaleFactor = scaleFactor.clamp(0.8, 1.0);

        return Center(
          child: Transform.scale(scale: scaleFactor, child: widget.child[actualIndex]),
        );
      },
    );
  }
}
