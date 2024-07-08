// ignore_for_file: unused_field

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/src/core/extensions/material_extensions.dart';

import '../../../core/assets/assets.gen.dart';

class MyProjectSection extends StatelessWidget {
  const MyProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return const DesktopContent();
        } else {
          return const MobileContent();
        }
      },
    );
  }
}

final List<ProjectData> _projects = [
  ProjectData(
    image: Assets.projects.p1t0.path,
    number: '01',
    name: 'Loans Collection Application',
    subTitle: 'Loans Collection Application is internal application used by bank employees...',
    productImages: [
      Assets.projects.p1t0.path,
      Assets.projects.p1t1.path,
      Assets.projects.p1t2.path,
      Assets.projects.p1t3.path,
    ],
  ),
  ProjectData(
    image: Assets.projects.p1t1.path,
    number: '02',
    name: 'Dynamic Ecom Application',
    subTitle: 'It is an Ecom application where companies have all the customization features...',
    productImages: [
      Assets.projects.p1t1.path,
      Assets.projects.p1t0.path,
      Assets.projects.p1t2.path,
      Assets.projects.p1t3.path,
    ],
  ),
  ProjectData(
    image: Assets.projects.p1t2.path,
    number: '03',
    name: 'Rental',
    subTitle: 'Rental application details...',
    productImages: [
      Assets.projects.p1t2.path,
      Assets.projects.p1t3.path,
      Assets.projects.p1t0.path,
      Assets.projects.p1t1.path,
    ],
  ),
  ProjectData(
    image: Assets.projects.p1t3.path,
    number: '04',
    name: 'Recipes',
    subTitle: 'Recipe application is a food recipe application........',
    productImages: [
      Assets.projects.p1t3.path,
      Assets.projects.p1t2.path,
      Assets.projects.p1t1.path,
      Assets.projects.p1t0.path,
    ],
  ),
];

class DesktopContent extends StatefulWidget {
  const DesktopContent({super.key});

  @override
  State<DesktopContent> createState() => _DesktopContentState();
}

class _DesktopContentState extends State<DesktopContent> {
  late List<double> _factors;
  int? _activeIndex;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _factors = List.filled(_projects.length, 1 / _projects.length);
  }

  void _updateFactors(int index, {bool hover = false, bool click = false}) {
    setState(() {
      if (click) {
        _activeIndex = index;
        _pressed = true;
        for (int i = 0; i < _factors.length; i++) {
          _factors[i] = i == index ? 0.7 : 0.1;
        }
      } else if (hover && !_pressed) {
        for (int i = 0; i < _factors.length; i++) {
          _factors[i] = i == index ? 0.28 : 0.24;
        }
      } else if (!hover && !_pressed) {
        _factors = List.filled(_projects.length, 1 / _projects.length);
      }
    });
  }

  void _resetFactors() {
    setState(() {
      _factors = List.filled(_projects.length, 1 / _projects.length);
      _pressed = false;
      _activeIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 61.0, bottom: 10.0),
          child: Text(
            "Projects",
            style: TextStyle(color: context.colorTheme.inverseSurface, fontWeight: FontWeight.w900, fontSize: 31.0),
          ),
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              return CustomCard(
                _projects[index].image,
                align: const Alignment(0, 0),
                number: _projects[index].number,
                name: _projects[index].name,
                heightCard: 700.0,
                factor: _factors[index],
                subTitle: _projects[index].subTitle,
                onEnter: () => _updateFactors(index, hover: true),
                onExit: _resetFactors,
                onPressed: () => _updateFactors(index, click: true),
                onClosePressed: _resetFactors,
                productImages: _projects[index].productImages,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProjectData {
  final String image;
  final String number;
  final String name;
  final String subTitle;
  final List<String> productImages;

  ProjectData({
    required this.image,
    required this.number,
    required this.name,
    required this.subTitle,
    required this.productImages,
  });
}

class MobileContent extends StatefulWidget {
  const MobileContent({super.key});

  @override
  State<MobileContent> createState() => _MobileContentState();
}

class _MobileContentState extends State<MobileContent> {
  late List<double> _factors;
  int? _activeIndex;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _factors = List.filled(_projects.length, 1 / _projects.length);
  }

  void _updateFactors(int index, {bool hover = false, bool click = false}) {
    setState(() {
      if (click) {
        _activeIndex = index;
        _pressed = true;
        for (int i = 0; i < _factors.length; i++) {
          _factors[i] = i == index ? 0.7 : 0.1;
        }
      } else if (hover && !_pressed) {
        for (int i = 0; i < _factors.length; i++) {
          _factors[i] = i == index ? 0.28 : 0.24;
        }
      } else if (!hover && !_pressed) {
        _factors = List.filled(_projects.length, 1 / _projects.length);
      }
    });
  }

  void _resetFactors() {
    setState(() {
      _factors = List.filled(_projects.length, 1 / _projects.length);
      _pressed = false;
      _activeIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              "Projects",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24.0),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return MobileCustomCard(
                  image: _projects[index].image,
                  number: _projects[index].number,
                  name: _projects[index].name,
                  factor: _factors[index],
                  subTitle: _projects[index].subTitle,
                  onEnter: () => _updateFactors(index, hover: true),
                  onExit: _resetFactors,
                  onPressed: () => _updateFactors(index, click: true),
                  onClosePressed: _resetFactors,
                  productImages: _projects[index].productImages,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MobileCustomCard extends StatefulWidget {
  final String image;
  final String number;
  final String name;
  final double factor;
  final String subTitle;
  final VoidCallback onEnter;
  final VoidCallback onExit;
  final VoidCallback onPressed;
  final VoidCallback onClosePressed;
  final List<String> productImages;

  const MobileCustomCard({
    super.key,
    required this.image,
    required this.number,
    required this.name,
    required this.factor,
    required this.subTitle,
    required this.onEnter,
    required this.onExit,
    required this.onPressed,
    required this.onClosePressed,
    required this.productImages,
  });

  @override
  State<MobileCustomCard> createState() => _MobileCustomCardState();
}

class _MobileCustomCardState extends State<MobileCustomCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = widget.factor > 0.5;
    final width = MediaQuery.of(context).size.width * widget.factor;

    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (_) => widget.onEnter(),
        onExit: (_) => widget.onExit(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: isExpanded
                      ? PageView.builder(
                          controller: _pageController,
                          itemCount: widget.productImages.length,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.asset(
                              widget.productImages[index],
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              if (isExpanded)
                Positioned(
                  bottom: 160,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.productImages.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: isExpanded ? 150 : 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.number,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.name,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 5),
                        Text(
                          widget.subTitle,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: widget.onClosePressed,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String image;
  final Alignment? align;
  final String? number;
  final String? name;
  final double? factor;
  final Function? onEnter;
  final Function? onExit;
  final Function? onPressed;
  final Function? onClosePressed;
  final String? subTitle;
  final double? heightCard;
  final List<String> productImages;

  const CustomCard(
    this.image, {
    super.key,
    this.align,
    this.heightCard,
    this.number,
    this.name,
    this.factor,
    this.onEnter,
    this.onExit,
    this.onPressed,
    this.onClosePressed,
    this.subTitle,
    required this.productImages,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  Color color = Colors.black12;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onEnter: (value) {
        widget.onEnter!();
      },
      onExit: (value) {
        widget.onExit!();
      },
      child: GestureDetector(
        onTap: () {
          widget.onPressed!();
        },
        child: Stack(
          children: [
            AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 0.2,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.factor == 0.25 || widget.factor == 0.24 ? color : Colors.transparent,
                    widget.factor == 0.25 || widget.factor == 0.24 ? color : Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
              curve: Curves.ease,
              duration: const Duration(milliseconds: 275),
              height: widget.heightCard,
              width: (MediaQuery.of(context).size.width * widget.factor!),
              child: widget.factor == 0.7
                  ? ProductImagesCarousel(images: widget.productImages)
                  : Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              child: AnimatedOpacity(
                opacity: (widget.factor == 0.7 || widget.factor == 0.1) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: (widget.factor == 0.7 || widget.factor == 0.1) ? 0.0 : 40.0,
                  width: 80.0,
                  child: Text(
                    widget.number!,
                    style: const TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -40.0,
              bottom: 60.0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 130.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - widget.name!.length * 5.0,
                      width: 1.5,
                      alignment: const Alignment(0.0, -1.0),
                      child: AnimatedContainer(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 375),
                        height: (widget.factor == 0.28 || widget.factor == 0.1 || widget.factor == 0.7) ? MediaQuery.of(context).size.height : 0.0,
                        width: 3.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 450),
                      opacity: (widget.factor == 0.28 || widget.factor == 0.1 || widget.factor == 0.7) ? 1.0 : 0.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 450),
                        height: (widget.factor == 0.28 || widget.factor == 0.1 || widget.factor == 0.7) ? 30.0 : 0.0,
                        width: 120.0,
                        child: Transform.rotate(
                          angle: -(math.pi) / 2,
                          child: Text(
                            widget.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 375),
              top: (widget.factor == 0.7) ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height - widget.name!.length * 7.0,
              right: 5.0,
              child: AnimatedOpacity(
                opacity: (widget.factor == 0.7) ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {}),
                ),
              ),
            ),
            AnimatedPositioned(
              left: (widget.factor == 0.7) ? 0.0 : -300.0,
              duration: const Duration(milliseconds: 475),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 300.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black54,
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
            AnimatedPositioned(
              left: (widget.factor == 0.7) ? 10.0 : -300.0,
              duration: const Duration(milliseconds: 475),
              child: AnimatedOpacity(
                opacity: (widget.factor == 0.7) ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 475),
                child: SizedBox(
                  height: 350.0,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          widget.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.subTitle!,
                          style: const TextStyle(
                            backgroundColor: Colors.black12,
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 35.0,
              top: 0.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: widget.factor == 0.7 ? 30.0 : 0.0,
                width: widget.factor == 0.7 ? 50.0 : 0.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget.onClosePressed!();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImagesCarousel extends StatelessWidget {
  final List<String> images;

  const ProductImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                images[index],
                // width: size.width > 1300 ? 400 : (size.width > 800 ? 300 : 150),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
