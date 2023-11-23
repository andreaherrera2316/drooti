import 'package:flutter/material.dart';

class DeviceType {
  final double width;
  final double height;

  DeviceType(this.width, this.height);

  bool get shortScreen => height <= 600;
  bool get mediumScreen => height > 600 && height <= 1200;
  bool get longScreen => height > 1200;

  bool get isMobile {
    return width < 600 || height < 600;
  }

  bool get isTablet {
    return width >= 600 && width < 1024;
  }

  bool get isDesktop {
    return width >= 1024;
  }

  /// Returns the corresponding value for the screen, whenever context is provided,
  /// the function checks for the devices orientation, and takes it into consideration
  /// when deciding the tablet value to return when no tablet value is provided
  X? getValueForScreen<X>(
      {X? onMobile, X? onTablet, X? onDesktop, BuildContext? context}) {
    bool isPortait = true;
    if (context != null) {
      final orientation = MediaQuery.of(context).orientation;
      isPortait = orientation == Orientation.portrait;
    }

    if (isMobile) {
      return onMobile ?? onTablet ?? onDesktop;
    } else if (isTablet) {
      if (onTablet != null) {
        return onTablet;
      } else if (isPortait) {
        return onMobile ?? onTablet ?? onDesktop;
      } else {
        return onTablet ?? onDesktop ?? onMobile;
      }
    } else {
      return onDesktop ?? onTablet ?? onMobile;
    }
  }
}
