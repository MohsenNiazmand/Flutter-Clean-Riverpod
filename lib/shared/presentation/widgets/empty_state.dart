import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/cupertino.dart';

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
          Icon(Icons.edit_note_rounded,size: dimen120,color: cPrimary,),
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
