import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/core/utils/pick_file.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/main_screen_provider.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/providers/post_provider.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_cached_image.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_circle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends HookConsumerWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    return Drawer(
      backgroundColor: cWhite,
      width: deviceType == DeviceTypeEnum.tablet ? dimen512 : dimen288,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: deviceType == DeviceTypeEnum.mobile
                ? const EdgeInsets.only(top: dimen16, left: dimen32)
                : deviceType == DeviceTypeEnum.tablet
                    ? const EdgeInsets.only(left: dimen72, top: dimen24)
                    : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  textColor: Colors.blue,
                  size: deviceType == DeviceTypeEnum.mobile ? 100 : null,
                ),
                _nameAndPicture(
                  context,
                  ref,
                  'User name',
                  '',
                ),
                Divider(
                  endIndent:
                      deviceType == DeviceTypeEnum.tablet ? dimen72 : dimen32,
                ),
                drawerItem(context.tr.home, Assets.icHome, () async {
                  if (kIsWeb) {
                    // ref
                    //     .read(getPositionsNotifierProvider.notifier)
                    //     .clearFilters();
                  }
                  GlobalKeys.drawerKey.currentState?.closeDrawer();
                  if (context.mounted) {
                    ref.read(currentLocationProvider.notifier).state =
                        Routes.home;
                    context.go(Routes.home);
                  }
                }),
                drawerItem(context.tr.profile, Assets.icProfile, () {
                  GlobalKeys.drawerKey.currentState?.closeDrawer();
                  if (ref.read(currentLocationProvider.notifier).state !=
                      Routes.profile) {
                    getIt<SecureStorage>()
                        .set(currentLocationWeb, Routes.profile);
                    ref.read(currentLocationProvider.notifier).state =
                        Routes.profile;
                    context.push(Routes.profile);
                  }
                }),
                Divider(
                  endIndent:
                      deviceType == DeviceTypeEnum.tablet ? dimen72 : dimen32,
                ),
                Gap.v8(),
                drawerItem(context.tr.aboutUs, Assets.icAboutUs, () {
                  GlobalKeys.drawerKey.currentState?.closeDrawer();

                  // if (ref.read(currentLocationProvider.notifier).state !=
                  //     Routes.aboutUs) {
                  //   context.push(Routes.aboutUs);
                  // }
                }),
                drawerItem(context.tr.privacyPolicy, Assets.icPrivacyPolicy,
                    () {
                  GlobalKeys.drawerKey.currentState?.closeDrawer();

                  // if (ref.read(currentLocationProvider.notifier).state !=
                  //     Routes.privacyPolicy) {
                  //   context.push(Routes.privacyPolicy);
                  // }
                }),
                drawerItem(context.tr.contactUs, Assets.icContactUs, () {
                  GlobalKeys.drawerKey.currentState?.closeDrawer();

                  // if (ref.read(currentLocationProvider.notifier).state !=
                  //     Routes.contactUs) {
                  //   context.push(Routes.contactUs);
                  // }
                }),
                Divider(
                  endIndent:
                      deviceType == DeviceTypeEnum.tablet ? dimen72 : dimen32,
                ),
                Gap.v8(),
                drawerItem(context.tr.logout, Assets.icLogout, () async {
                  // final result = await ref
                  //     .read(logoutNotifierProvider.notifier)
                  //     .logout();
                  // if (result && context.mounted) {
                  GlobalKeys.drawerKey.currentState?.closeDrawer();
                  await getIt<SecureStorage>().clear();
                  if (context.mounted) {
                    context.go(Routes.login);
                  } // }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _nameAndPicture(
    BuildContext context,
    WidgetRef ref,
    String fullName,
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: dimen12),
      child: Row(
        children: [
          InkWell(
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
            child: Stack(
              children: [
                Align(
                  child: PrimaryCachedImage(
                    image,
                    width: dimen40,
                    height: dimen40,
                    borderRadius: BorderRadius.circular(dimen24),
                  ),
                ),
                if (image.isNotEmpty)
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    child: PrimaryCircle(
                      defaultShadow: true,
                      size: dimen16,
                      child: Icon(
                        Icons.edit_outlined,
                        color: cPrimary,
                        size: dimen12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Gap.h12(),
          Text(
            fullName,
            style: AppStyles().styleText_12_500(),
          ),
        ],
      ),
    );
  }
}

Widget drawerItem(
  String text,
  String svgPath,
  void Function() onTap, {
  Color? svgColor,
}) =>
    Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, dimen8, dimen8, dimen8),
            width: dimen200,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    svgPath,
                    colorFilter:
                        ColorFilter.mode(svgColor ?? cText, BlendMode.srcIn),
                  ),
                ),
                Gap.h16(),
                Text(
                  text,
                  style: AppStyles().styleText_12_500(),
                ),
              ],
            ),
          ),
        ),
        Gap.v16(),
      ],
    );
