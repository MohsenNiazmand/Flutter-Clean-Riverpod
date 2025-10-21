import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationButton extends HookConsumerWidget {
  const NavigationButton({
    required this.index,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final int index;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final svgPath = useState(Assets.icHome);
    final text = useState('');
    void recognizeIcon(int i) {
      svgPath.value = index == 0
          ? Assets.icHome
          :  Assets.icProfile;

    }

    void recognizeText(int i) {
      text.value = index == 0
          ? context.tr.home
          : context.tr.profile
           ;
    }

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((z) {
          recognizeIcon(index);
          recognizeText(index);
        });
        return null;
      },
      [],
    );
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(dimen8),
            child: Column(
              children: [
                SvgPicture.asset(
                  svgPath.value,
                  colorFilter: selected
                      ? const ColorFilter.mode(cPrimary, BlendMode.srcIn)
                      : null,
                ),
                Gap.v4(),
                Text(
                  text.value,
                  style: AppStyles()
                      .styleText_12_400()
                      .apply(color: selected ? cPrimary : cText),
                ),
              ],
            ),
          ),
        ),
        Gap.h32(),
      ],
    );
  }
}
