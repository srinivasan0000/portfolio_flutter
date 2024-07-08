import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:motion/motion.dart';
import '../core/extensions/material_extensions.dart';

class TimelineWidget extends StatelessWidget {
  final List<TimelineEntry> entries;
  final double height;
  final double width;

  const TimelineWidget({
    super.key,
    required this.entries,
    this.height = 300,
    this.width = 500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return TimelineEntryWidget(
            entry: entry,
            isLast: index == entries.length - 1,
            height: height,
            width: width,
          ).animate().fadeIn(duration: 300.ms, delay: (index * 100).ms).slideX(begin: 0.2, end: 0);
        },
      ),
    );
  }
}

class TimelineEntryWidget extends StatelessWidget {
  final TimelineEntry entry;
  final bool isLast;
  final double height;
  final double width;

  const TimelineEntryWidget({
    super.key,
    required this.entry,
    required this.isLast,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 500;
    String dateRange = entry.fromDate.year == entry.toDate.year ? '${entry.fromDate.year}' : '${entry.fromDate.year} - ${isLast ? "Present" : entry.toDate.year}';

    Duration difference = entry.toDate.difference(entry.fromDate);

    return SizedBox(
      width: isMobile ? width - 100 : width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconAndLine(context),
          _buildCard(context, isMobile, dateRange, difference),
        ],
      ),
    );
  }

  Widget _buildIconAndLine(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container(height: 2, color: context.colorTheme.secondary)),
              _buildIconCircle(context),
              Expanded(child: Container(height: 2, color: context.colorTheme.secondary)),
            ],
          ),
          Expanded(child: Container(width: 2, color: context.colorTheme.tertiary)),
        ],
      ),
    );
  }

  Widget _buildIconCircle(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorTheme.tertiary.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: context.colorTheme.tertiary.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          SpinKitDoubleBounce(
            duration: const Duration(seconds: 7),
            color: context.colorTheme.tertiary,
            size: 50,
          ),
          Center(
            child: Icon(
              entry.icon,
              color: context.colorTheme.tertiaryContainer,
              size: 24,
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeInOut).then().shimmer(duration: 1200.ms, color: context.colorTheme.tertiary.withOpacity(0.3));
  }

  Widget _buildCard(BuildContext context, bool isMobile, String dateRange, Duration difference) {
    return Motion(
      shadow: const ShadowConfiguration(
        opacity: 0.2,
        blurRadius: 30,
        color: Colors.black,
      ),
      child: Container(
        width: isMobile ? width - 120 : width - 20,
        height: height - 80,
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.colorTheme.shadow.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateRange(context, dateRange),
              const SizedBox(height: 8),
              _buildTitle(context),
              const SizedBox(height: 8),
              _buildDescription(context),
              const SizedBox(height: 8),
              _buildDuration(context, difference),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRange(BuildContext context, String dateRange) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        dateRange,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: context.colorTheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      entry.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: context.colorTheme.onSurface,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Text(
          entry.description,
          style: TextStyle(
            fontSize: 14,
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildDuration(BuildContext context, Duration difference) {
    String durationText = difference.inDays > 365 ? '${difference.inDays ~/ 365} years ${difference.inDays % 365 ~/ 30} months' : '${difference.inDays ~/ 30} months';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorTheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        durationText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: context.colorTheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class TimelineEntry {
  final String title;
  final String description;
  final DateTime fromDate;
  final DateTime toDate;

  final IconData icon;

  TimelineEntry({
    required this.fromDate,
    required this.toDate,
    required this.title,
    required this.description,
    required this.icon,
  });
}
// -----------------------------------------------

class SpinKitDoubleBounce extends StatefulWidget {
  const SpinKitDoubleBounce({
    super.key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2000),
    this.controller,
  }) : assert(
          !(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
          'You should specify either a itemBuilder or a color',
        );

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<SpinKitDoubleBounce> createState() => _SpinKitDoubleBounceState();
}

class _SpinKitDoubleBounceState extends State<SpinKitDoubleBounce> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..repeat(reverse: true);
    _animation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: List.generate(2, (i) {
          return Transform.scale(
            scale: (1.0 - i - _animation.value.abs()).abs(),
            child: SizedBox.fromSize(
              size: Size.square(widget.size),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color!.withOpacity(0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
