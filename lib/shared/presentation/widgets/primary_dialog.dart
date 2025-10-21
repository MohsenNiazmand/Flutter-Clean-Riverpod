import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:go_router/go_router.dart';

class PrimaryDialog extends StatelessWidget {
  const PrimaryDialog({
    required this.child,
    required this.width,
    required this.height,
    this.title,
    this.padding,
    super.key,
  });

  final Widget child;
  final Widget? title;
  final double width;
  final double height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(dimen8)),
      backgroundColor: cWhite,
      child: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(dimen20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null) title! else const SizedBox(),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              Gap.v4(),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
