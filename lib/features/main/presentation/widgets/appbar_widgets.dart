import 'dart:math';

import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/core/utils/pick_file.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/main_screen_provider.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/widgets/navigation_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/providers/post_provider.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_cached_image.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_circle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/secondary_drop_down_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppbarWidgets extends HookConsumerWidget {
  const AppbarWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider);

    final routes = [
      Routes.home,
      Routes.profile,
    ];

    Future<String?> loadCurrentLocation() async {
      final prefs = getIt<SecureStorage>().get(currentLocationWeb);
      return prefs;
    }

    useEffect(
      () {
        loadCurrentLocation().then((location) {
          if (location != null && kIsWeb) {
            ref.read(currentLocationProvider.notifier).state = location;
          }
        });
        return null;
      },
      [],
    );
    return Row(
      children: [
        for (int i = 0; i < 2; i++)
          NavigationButton(
            index: i,
            selected: currentLocation == routes[i],
            onTap: () {

              context.go(routes[i]);
              ref.read(currentLocationProvider.notifier).state = routes[i];
              getIt<SecureStorage>().set(currentLocationWeb, routes[i]);
            },
          ),
        Gap.custom(
          width: dimen40,
        ),
        Row(
          children: [
            Text(
              'User name',
              style: AppStyles().styleText_12_400(),
            ),
            Gap.h12(),
            InkWell(
              key: GlobalKeys.appbarProfileKey,
              onTapDown: (details) {
                final RenderBox? renderBox = GlobalKeys
                    .appbarProfileKey.currentContext
                    ?.findRenderObject() as RenderBox?;
                final offset = renderBox?.localToGlobal(Offset.zero);
                if (offset != null) {
                  showProfileDropDown(
                    context,
                    offset,
                    renderBox,
                    false,
                    ref,
                  );
                }
              },
              child: Stack(
                children: [
                  Align(
                    child: PrimaryCachedImage(
                      '',
                      width: dimen40,
                      height: dimen40,
                      borderRadius: BorderRadius.circular(dimen32),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  static const double sideLength =
      11; // Side length of the equilateral triangle
  static final double height = (sqrt(3) / 2) * sideLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cWhite
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top center of the triangle
      ..lineTo(size.width / 2 + sideLength / 2, height) // Bottom right corner
      ..lineTo(size.width / 2 - sideLength / 2, height) // Bottom left corner
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void showProfileDropDown(
  BuildContext context,
  Offset offset,
  RenderBox? renderBox,
  bool hasProfileImage,
  WidgetRef ref,
) {
  showMenu(
    context: context,
    color: cWhite,
    elevation: 1,
    constraints: const BoxConstraints(maxWidth: 186),
    position: RelativeRect.fromLTRB(
      offset.dx - dimen120,
      offset.dy + 64,
      offset.dx,
      offset.dy,
    ),
    items: [
      PopupMenuItem<int>(
        value: 0,
        padding: EdgeInsets.zero,
        child: SecondaryDropDownItem(
          text: context.tr.profile,
          svgPath: Assets.icProfile,
          onTap: () {
            final currentLocation = GoRouter.of(context)
                .routerDelegate
                .currentConfiguration
                .fullPath;
            if (ref.read(currentLocationProvider.notifier).state !=
                    '/profile' ||
                currentLocation != Routes.profile) {
              getIt<SecureStorage>().set(currentLocationWeb, '/profile');
              ref.read(currentLocationProvider.notifier).state = '/profile';
              context.push(Routes.profile);
            }
          },
        ),
      ),
      PopupMenuItem<int>(
        value: 1,
        padding: EdgeInsets.zero,
        child: SecondaryDropDownItem(
          text: hasProfileImage
              ? context.tr.updateProfileImage
              : context.tr.setProfileImage,
          svgPath: Assets.icEditProfile,
          onTap: () async {
            final xFile = await pickFile(
              type: FileType.image,
            );
            if (xFile != null) {
              final Uint8List file = await xFile.readAsBytes();
              // await ref
              //     .read(initProfileProvider.notifier)
              //     .uploadProfilePicture(file, xFile.name);
            }
          },
        ),
      ),
      PopupMenuItem<int>(
        value: 2,
        padding: EdgeInsets.zero,
        child: SecondaryDropDownItem(
          text: context.tr.logout,
          svgPath: Assets.icLogout,
          onTap: () async {
            await getIt<SecureStorage>().clear();
            if(context.mounted) {
              context.go(Routes.login);
            }
          },
        ),
      ),
    ],
  );
}
