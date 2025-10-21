import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icEmptyState),
          Gap.v16(),
          if (text != null)
            Text(
              text!,
              style: AppStyles().styleText_18_500(),
            ),
        ],
      ),
    );
  }
}
