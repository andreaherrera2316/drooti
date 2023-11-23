import 'package:app/resources/sizing/device_type.dart';

class ValueBasedOnScreen {
  double getValueOnWidth(
      {required double mobile,
      required double tablet,
      required double desktop,
      required double screenWidth}) {
    var d = DeviceType(screenWidth, 0);
    if (d.isDesktop) {
      return desktop;
    } else if (d.isTablet) {
      return tablet;
    }
    return mobile;
  }

  double getValueOnHeight(
      {required double shortScreen,
      required double mediumScreen,
      required double longScreen,
      required double screenHeight}) {
    var d = DeviceType(0, screenHeight);
    if (d.shortScreen) {
      return shortScreen;
    } else if (d.mediumScreen) {
      return mediumScreen;
    } else if (d.longScreen) {
      return longScreen;
    } else {
      return longScreen;
    }
  }
}
