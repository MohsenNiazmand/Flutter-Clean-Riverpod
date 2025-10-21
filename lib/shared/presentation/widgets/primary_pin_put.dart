import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PrimaryPinPut extends StatelessWidget {
  const PrimaryPinPut({
    required this.fieldCount,
    required this.onSubmit,
    this.padding = EdgeInsets.zero,
    this.withCursor = false,
    this.onChanged,
    this.controller,
    this.fillColor = cGrey,
    this.isCircular = false,
    this.width = 28,
    this.height = 32,
    this.focusNode,
    super.key,
  });

  final bool withCursor;
  final int fieldCount;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final Color fillColor;
  final bool isCircular;
  final double width;
  final double height;

  BoxDecoration _pinPutDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(color: cGrey),
        borderRadius: BorderRadius.circular(isCircular ? height / 2 : 2),
        color: fillColor,
      );

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: width,
      height: height,
      textStyle: AppStyles().styleText_11_500().apply(color: cPrimary),
      decoration: _pinPutDecoration(context),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: cGrey),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        //can add some styles
        );
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          length: fieldCount,
          showCursor: withCursor,
          onSubmitted: onSubmit,
          onCompleted: onSubmit,
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
        ),
      ),
    );
  }
}
