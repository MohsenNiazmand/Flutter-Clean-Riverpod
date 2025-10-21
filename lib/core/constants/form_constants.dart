import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

class FormConstants {
  static OutlineInputBorder defaultBorder(
    BuildContext context,
    double? radius,
  ) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? dimen4),
        borderSide: const BorderSide(
          color: cWhite,
        ),
      );

  static OutlineInputBorder errorBorder(BuildContext context, double? radius) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? dimen4),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      );

  static UnderlineInputBorder errorBorderUnderline(
    BuildContext context,
    double? radius,
  ) =>
      UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      );

  static OutlineInputBorder focusBorder(BuildContext context, double? radius) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? dimen4),
        borderSide: const BorderSide(
          color: cTextSubtitle,
        ),
      );
}
