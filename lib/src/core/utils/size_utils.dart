import 'package:flutter/widgets.dart';

//rare usage of this class
class TSizeUtils {
  TSizeUtils._();

  static double doubleCurrentWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double doubleCurrentHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double hPercent(double percent, {required BuildContext context}) {
    double height = MediaQuery.of(context).size.height;
    return (height / 100) * percent;
  }

  static double wPercent(double percent, {required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    return (width / 100) * percent;
  }

  static double aHPercent(double percent, {required BuildContext context}) {
    double height = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.vertical;
    double availableHeight = height - safeAreaHeight;
    return (availableHeight / 100) * percent;
  }

  static double aHPercentWithAppBar(double percent, {required BuildContext context, required PreferredSizeWidget appBar}) {
    double height = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.vertical;
    double appBarHeight = appBar.preferredSize.height;
    double availableHeight = height - safeAreaHeight - appBarHeight;
    return (availableHeight / 100) * percent;
  }

  static double aHPercentWithSliverAppBar(double percent, {required BuildContext context, required double appBarHeight}) {
    double height = MediaQuery.of(context).size.height;
    double availableHeight = height - appBarHeight;
    return (availableHeight / 100) * percent;
  }

  static double aWPercent(double percent, {required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;
    double safeAreaWidth = MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right;
    double availableWidth = width - safeAreaWidth;
    return (availableWidth / 100) * percent;
  }
}
