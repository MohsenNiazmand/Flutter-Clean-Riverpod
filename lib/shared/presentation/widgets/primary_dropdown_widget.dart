import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter/material.dart';

class PrimaryDropdownWidget extends StatelessWidget {
  const PrimaryDropdownWidget({
    required this.text,
    required this.isOpen,
    required this.widgetKey,
    required this.showDropdown,
    this.padding,
    this.width,
    this.height,
    this.radius,
    this.hasShadow = false,
    super.key,
  });

  final String text;
  final bool isOpen;
  final GlobalKey widgetKey;
  final void Function(BuildContext context, Offset offset, double width)
      showDropdown;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final double? radius;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return PrimaryRectangle(
      key: widgetKey,
      width: width,
      height: height,
      radius: radius ?? 8,
      defaultShadow: hasShadow,
      padding: padding ?? const EdgeInsets.all(dimen16),
      onTapDown: (details) {
        final RenderBox? renderBox =
            widgetKey.currentContext?.findRenderObject() as RenderBox?;
        final offset = renderBox?.localToGlobal(Offset.zero);
        final widgetWidth = renderBox?.size.width;
        showDropdown(context, offset ?? Offset.zero, widgetWidth ?? 0);
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppStyles().styleText_14_500(),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isOpen
                ? const Icon(key: Key('up'), Icons.keyboard_arrow_up_rounded)
                : const Icon(
                    key: Key('down'),
                    Icons.keyboard_arrow_down_rounded,
                  ),
          ),
        ],
      ),
    );
  }
}
