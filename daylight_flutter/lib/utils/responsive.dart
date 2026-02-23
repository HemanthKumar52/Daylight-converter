import 'package:flutter/material.dart';

/// Device type based on screen width
enum DeviceType { mobile, tablet, desktop }

/// Responsive utility class for handling different screen sizes
class Responsive {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Max content widths
  static const double maxCardWidth = 500;
  static const double maxSliderWidth = 600;
  static const double maxSheetWidth = 600;
  static const double maxContentWidth = 1200;

  /// Get the current device type based on screen width
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if the device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  /// Check if the device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  /// Check if the device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  /// Check if the device is tablet or larger
  static bool isTabletOrLarger(BuildContext context) {
    return !isMobile(context);
  }

  /// Get the number of columns for grid layout based on screen width
  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return 1;
    } else if (width < tabletBreakpoint) {
      return 2;
    } else if (width < desktopBreakpoint) {
      return 2;
    } else {
      return 3;
    }
  }

  /// Get horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 32;
      case DeviceType.desktop:
        return 48;
    }
  }

  /// Get card height based on screen size
  static double getCardHeight(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 108;
      case DeviceType.tablet:
        return 120;
      case DeviceType.desktop:
        return 130;
    }
  }

  /// Get slider height based on screen size
  static double getSliderHeight(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 128;
      case DeviceType.tablet:
        return 140;
      case DeviceType.desktop:
        return 150;
    }
  }

  /// Get header font size based on screen size
  static double getHeaderFontSize(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 36;
      case DeviceType.tablet:
        return 42;
      case DeviceType.desktop:
        return 48;
    }
  }

  /// Get block width for timezone cards based on screen size
  static double getBlockWidth(BuildContext context) {
    final deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 190;
      case DeviceType.tablet:
        return 220;
      case DeviceType.desktop:
        return 250;
    }
  }

  /// Get bottom sheet constraints
  static BoxConstraints getSheetConstraints(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > mobileBreakpoint) {
      return BoxConstraints(
        maxWidth: maxSheetWidth,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      );
    }
    return const BoxConstraints();
  }

  /// Wrap content with centered max width constraint for large screens
  static Widget constrainWidth(Widget child, {double maxWidth = maxContentWidth}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
