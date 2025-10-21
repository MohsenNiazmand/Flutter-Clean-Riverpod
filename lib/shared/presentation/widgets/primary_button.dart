import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum ButtonType {
  primary,
  secondary,
}

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.onPress,
    required this.text,
    super.key,
    this.borderRadius,
    this.type = ButtonType.primary,
    this.suffixIcon,
    this.prefixIcon,
    this.color,
    this.foregroundColor,
    this.width,
    this.height = 36,
    this.borderColor,
    this.enabled = true,
    this.loading = false,
    this.padding,
  });

  final String text;
  final void Function() onPress;
  final double? width;
  final double? height;
  final Color? color;
  final Color? foregroundColor;
  final Color? borderColor;
  final ButtonType type;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final bool loading;
  final EdgeInsets? padding;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: (widget.enabled && !widget.loading) ? widget.onPress : null,
        style: ElevatedButton.styleFrom(
          padding:
              widget.padding ?? const EdgeInsets.symmetric(horizontal: dimen16),
          foregroundColor: widget.foregroundColor ?? Colors.transparent,
          backgroundColor: widget.color ?? _getTypeColor(context, widget),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
            side: (widget.type == ButtonType.secondary && !widget.loading)
                ? BorderSide(color: _getOnTypeColor(context, widget.type))
                : BorderSide(color: _getTypeColor(context, widget)),
          ),
          elevation: 0,
        ),
        child: AnimatedSwitcher(
          duration: Durations.medium2,
          child: widget.loading
              ? SizedBox(
                  key: const Key('loading'),
                  width: widget.width ?? dimen48,
                  height: dimen32,
                  child: Lottie.asset(Assets.threeDotsAnim),
                )
              : Wrap(
                  key: const Key('widgets'),
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (widget.prefixIcon != null) widget.prefixIcon!,
                    if (widget.prefixIcon != null) Gap.h4(),
                    Text(
                      widget.text,
                      style: AppStyles().styleText_14_600().copyWith(
                            color: (widget.foregroundColor != null)
                                ? widget.foregroundColor
                                : widget.type == ButtonType.primary
                                    ? cWhite
                                    : cPrimary,
                          ),
                    ),
                    if (widget.suffixIcon != null) Gap.h4(),
                    if (widget.suffixIcon != null) widget.suffixIcon!,
                  ],
                ),
        ),
      ),
    );
  }

  Color _getTypeColor(BuildContext context, PrimaryButton widget) {
    if (widget.color != null) {
      return widget.color!;
    }

    if (!widget.enabled || widget.loading) {
      return cGrey;
    }

    switch (widget.type) {
      case ButtonType.primary:
        return cPrimary;
      case ButtonType.secondary:
        return cWhite;
    }
  }

  Color _getOnTypeColor(BuildContext context, ButtonType type) {
    if (widget.borderColor != null) {
      return widget.borderColor!;
    }
    if (!widget.enabled) {
      return cWhite;
    }
    switch (type) {
      case ButtonType.primary:
        return cPrimary;
      case ButtonType.secondary:
        return cPrimary;
    }
  }
}
