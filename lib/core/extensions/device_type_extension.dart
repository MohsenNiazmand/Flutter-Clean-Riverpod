import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/material.dart';

/// Extension for responsive UI design based on device screen width.
/// 
/// This extension provides a simple way to determine device type (mobile, tablet, desktop)
/// by checking the current screen width. It helps create responsive layouts that adapt
/// to different screen sizes without complex breakpoint management.
/// 
/// Usage:
/// ```dart
/// if (context.deviceType == DeviceTypeEnum.mobile) {
///   // Mobile-specific UI
/// } else if (context.deviceType == DeviceTypeEnum.tablet) {
///   // Tablet-specific UI
/// } else {
///   // Desktop-specific UI
/// }
/// ```
/// 
/// Breakpoints:
/// - Mobile: width < 600px
/// - Tablet: 600px <= width < 1250px  
/// - Desktop: width >= 1250px
extension DeviceTypeExtension on BuildContext {
  DeviceTypeEnum get deviceType {
    final deviceWidth = MediaQuery.of(this).size.width;

    if (deviceWidth < 600) {
      return DeviceTypeEnum.mobile;
    } else if (deviceWidth >= 600 && deviceWidth < 1250) {
      return DeviceTypeEnum.tablet;
    } else {
      return DeviceTypeEnum.desktop;
    }
  }
}
