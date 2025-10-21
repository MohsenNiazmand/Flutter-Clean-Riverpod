import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrimaryDropdownTextField extends HookConsumerWidget {
  const PrimaryDropdownTextField({
    required this.labelText,
    this.secondLabelText,
    required this.hintText,
    required this.isOpen,
    required this.widgetKey,
    required this.showDropdown,
    this.isRequired=true,
    super.key,
  });

  final String labelText;
  final String? secondLabelText;
  final String hintText;
  final bool isOpen;
  final bool isRequired;
  final GlobalKey widgetKey;
  final void Function(
    BuildContext context,
    Offset offset,
    double width,
  ) showDropdown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      key: widgetKey,
      onTapDown: (details) async {
        FocusScope.of(context).requestFocus(FocusNode());
        final RenderBox? renderBox =
            widgetKey.currentContext?.findRenderObject() as RenderBox?;
        final offset = renderBox?.localToGlobal(Offset.zero);
        final widgetWidth = renderBox?.size.width;

        if (offset != null) {
          showDropdown(context, offset, widgetWidth ?? 0);
        }
      },
      child: PrimaryTextField(
        label: '$labelText${ secondLabelText ?? ''}',
        name: labelText,
        isRequired: isRequired,
        labelPadding: const EdgeInsets.only(bottom: dimen8),
        hint: hintText,
        enabled: false,
        suffixIcon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isOpen
              ? const Icon(key: Key('up'), Icons.keyboard_arrow_up_rounded)
              : const Icon(key: Key('down'), Icons.keyboard_arrow_down_rounded),
        ),
      ),
    );
  }
}
