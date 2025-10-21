import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_circle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrimaryErrorWidget extends HookConsumerWidget {
  const PrimaryErrorWidget({
    required this.onReloadTap,
    this.errorText,
    this.height,
    this.textStyle,
    super.key,
  });

  final String? errorText;
  final double? height;
  final TextStyle? textStyle;
  final void Function() onReloadTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.tr.errorWidgetText,
            style: AppStyles().styleText_14_400(),
          ),
          Gap.v16(),
          PrimaryCircle(
            onTap: onReloadTap,
            size: dimen32,
            color: cPrimary,
            child: const Icon(
              Icons.refresh,
              color: cWhite,
            ),
          ),
        ],
      ),
    );
  }
}
