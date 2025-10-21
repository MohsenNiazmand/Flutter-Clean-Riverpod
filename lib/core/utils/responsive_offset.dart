import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/foundation.dart';

/// Provides responsive vertical offset values based on device type and platform.
/// Different offsets for web vs mobile to account for platform-specific UI differences.
double responsiveOffset(DeviceTypeEnum deviceType) {
  double yOffset = 0;
  if (kIsWeb) {
    if (deviceType == DeviceTypeEnum.mobile) {
      yOffset = 12;
    }
    if (deviceType == DeviceTypeEnum.tablet) {
      yOffset = 4;
    }
    if (deviceType == DeviceTypeEnum.desktop) {
      yOffset = -12;
    }
  } else {
    if (deviceType == DeviceTypeEnum.mobile) {
      yOffset = 0;
    }
    if (deviceType == DeviceTypeEnum.tablet) {
      yOffset = -8;
    }
    if (deviceType == DeviceTypeEnum.desktop) {
      yOffset = -24;
    }
  }
  return yOffset;
}

double responsiveOffsetSecondary(DeviceTypeEnum deviceType) {
  double yOffset = 0;
  if (kIsWeb) {
    if (deviceType == DeviceTypeEnum.mobile) {
      yOffset = 4;
    }
    if (deviceType == DeviceTypeEnum.tablet) {
      yOffset = -8;
    }
    if (deviceType == DeviceTypeEnum.desktop) {
      yOffset = -32;
    }
  } else {
    if (deviceType == DeviceTypeEnum.mobile) {
      yOffset = -24;
    }
    if (deviceType == DeviceTypeEnum.tablet) {
      yOffset = -32;
    }
    if (deviceType == DeviceTypeEnum.desktop) {
      yOffset = -56;
    }
  }
  return yOffset;
}
