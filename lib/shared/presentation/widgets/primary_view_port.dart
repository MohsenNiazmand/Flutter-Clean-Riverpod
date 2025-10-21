import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/cupertino.dart';

class PrimaryViewPort extends StatelessWidget {
  const PrimaryViewPort({
    required this.desktop,
    required this.tablet,
    required this.mobile,
    super.key,
  });

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    final deviceType = context.deviceType;
    return switch (deviceType) {
      DeviceTypeEnum.mobile => mobile,
      DeviceTypeEnum.tablet => tablet,
      DeviceTypeEnum.desktop => desktop,
    };
  }
}
