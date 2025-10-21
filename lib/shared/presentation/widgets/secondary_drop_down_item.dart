import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecondaryDropDownItem extends HookConsumerWidget {
  const SecondaryDropDownItem({
    required this.text,
    required this.onTap,
    this.svgPath,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.radius,
    this.hasBadge,
    super.key,
  });

  final String text;
  final String? svgPath;
  final void Function() onTap;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? radius;
  final bool? hasBadge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovered = useState(false);
    final isPressed = useState(false);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onHover: (hovered) {
          isHovered.value = hovered;
        },
        onPressed: () {
          context.pop();
          isPressed.value = true;
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.pressed)) {
                return cPrimary50;
              }
              return cWhite;
            },
          ),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.pressed)) {
                return cPrimary50;
              }
              return null;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.pressed)) {
                return cPrimary;
              }
              return cIcon;
            },
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            padding ?? const EdgeInsets.all(dimen16),
          ),

          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: radius != null
                  ? BorderRadius.circular(radius ?? 0)
                  : BorderRadius.zero,
            ),
          ),
          textStyle: WidgetStatePropertyAll(AppStyles().styleText_12_500()),
          elevation: WidgetStateProperty.all(0), // Remove shadow if needed
        ),
        child: SizedBox(
          width: width ?? 186,
          height: height ?? 40,
          child: Row(
            children: [
              if ((hasBadge ?? false) && isHovered.value)
                PrimaryRectangle(
                  width: 4,
                  height: height ?? 40,
                  color: cPrimary,
                ),
              if (hasBadge ?? false) Gap.h16(),
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath ?? '',
                  width: dimen16,
                  height: dimen16,
                  colorFilter: isHovered.value
                      ? const ColorFilter.mode(cPrimary, BlendMode.srcIn)
                      : const ColorFilter.mode(cIcon, BlendMode.srcIn),
                ),
              if (svgPath != null) Gap.h8(),
              Expanded(
                child: Text(
                  text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
