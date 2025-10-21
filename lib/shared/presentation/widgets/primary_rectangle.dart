import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryRectangle extends StatelessWidget {
  const PrimaryRectangle({
    super.key,
    this.color = Colors.white,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.radius = 0,
    this.child = const SizedBox(),
    this.borderWith = 0,
    this.borderColor = const Color(0x1F000000),
    this.shadowRadius = 0,
    this.shadowColor = const Color(0x1F000000),
    this.shadowOffset = Offset.zero,
    this.onTap,
    this.onDoubleTap,
    this.onTapDown,
    this.gradient,
    this.customRadius,
    this.defaultShadow,
    this.boxConstraints,
  });

  final Color color;

  final double? width;

  final double? height;

  final BoxConstraints? boxConstraints;

  final EdgeInsetsGeometry padding;

  final EdgeInsetsGeometry margin;

  final double radius;

  final Widget child;

  final double borderWith;

  final Color borderColor;

  final double shadowRadius;

  final Color shadowColor;

  final Offset shadowOffset;

  final Gradient? gradient;

  final void Function()? onTap;

  final void Function()? onDoubleTap;

  final void Function(TapDownDetails)? onTapDown;

  final BorderRadiusGeometry? customRadius;

  final bool? defaultShadow;

  @override
  Widget build(BuildContext context) => InkWell(
    splashColor: Colors.transparent,
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    onTapDown: onTapDown,
    borderRadius: BorderRadius.circular(radius),
    child: Container(
      margin: margin,
      width: width,
      height: height,
      padding: padding,
      constraints: boxConstraints,
      decoration: BoxDecoration(
        border: borderWith > 0
            ? Border.all(color: borderColor, width: borderWith)
            : null,
        color: color,
        gradient: gradient,
        borderRadius: customRadius ?? BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            blurRadius: (defaultShadow ?? false) ? 20 : shadowRadius,
            color: (defaultShadow ?? false) ? cShadow : shadowColor,
            offset: (defaultShadow ?? false)
                ? const Offset(0, 6)
                : shadowOffset,
          ),
        ],
      ),
      child: child,
    ),
  );
}
