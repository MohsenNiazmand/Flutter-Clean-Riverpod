import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/material.dart';

class PrimaryCheckbox extends StatelessWidget {
  const PrimaryCheckbox({
    required this.text,
    required this.value,
    required this.onChanged,
    this.size,
    super.key,
  });

  final String text;
  final bool value;
  final void Function() onChanged;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Row(
        children: [
          Container(
            color: cGrey,
            width: size ?? 24,
            height: size ?? 24,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: cGrey),
              splashRadius: 4,
              activeColor: cGrey,
              checkColor: cPrimary,
              value: value,
              onChanged: (v) {
                onChanged();
              },
            ),
          ),
          Gap.h8(),
          Expanded(
            child: Text(
              text,
              style: AppStyles().styleText_12_500(),
            ),
          ),
        ],
      ),
    );
  }
}
