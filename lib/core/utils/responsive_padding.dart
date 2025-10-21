import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/material.dart';

/// Generates responsive padding based on device type.
/// Mobile: 32px horizontal, Tablet: 72px, Desktop: 176px.
EdgeInsets responsivePadding(DeviceTypeEnum deviceType,
    {bool defaultVerticalPadding = false,}) {
  return deviceType == DeviceTypeEnum.mobile
      ? EdgeInsets.symmetric(
          vertical: defaultVerticalPadding ? dimen32 : 0,
          horizontal: dimen32,
        )
      : deviceType == DeviceTypeEnum.tablet
          ? EdgeInsets.symmetric(
              vertical: defaultVerticalPadding ? dimen32 : 0,
              horizontal: dimen72,
            )
          : EdgeInsets.symmetric(
              vertical: defaultVerticalPadding ? dimen32 : 0,
              horizontal: dimen176,
            );
}
