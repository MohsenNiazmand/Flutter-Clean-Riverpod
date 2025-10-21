import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryCircle extends StatelessWidget {
  const PrimaryCircle({
    super.key,
    this.color = Colors.white,
    this.size = 48,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.child = const SizedBox(),
    this.borderWith = 0,
    this.borderColor = const Color(0x1F000000),
    this.shadowRadius = 0,
    this.shadowColor = const Color(0x1F000000),
    this.shadowOffset = Offset.zero,
    this.onTap,
    this.defaultShadow,
  });

  final Color color;

  final double size;

  final EdgeInsetsGeometry padding;

  final EdgeInsetsGeometry margin;

  final Widget child;

  final double borderWith;

  final Color borderColor;

  final void Function()? onTap;

  final double shadowRadius;

  final Color shadowColor;

  final Offset shadowOffset;

  final bool? defaultShadow;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(size / 2),
          child: Container(
            width: size,
            height: size,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
              border: borderWith > 0
                  ? Border.all(
                      color: borderColor,
                      width: borderWith,
                    )
                  : null,
              color: color,
              borderRadius: BorderRadius.circular(size / 2),
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
        ),
      );
}
