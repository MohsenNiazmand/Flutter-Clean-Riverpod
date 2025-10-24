import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/widgets/appbar_widgets.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/widgets/drawer_widget.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

DateTime? currentBackPressTime;

class MainScreen extends HookConsumerWidget {
  const MainScreen({
    required this.child,
    Key? key,
  }) : super(
          key: key ?? const ValueKey<String>('ScaffoldWithNavBar'),
        );
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    Future<bool> onWillPop() async {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
        return false;
      } else if (currentLocation != Routes.notes) {
        context.go(Routes.notes);
        return false;
      } else {
        final DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Press again to exit',
                style: AppStyles().styleText_14_400().apply(color: cWhite),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: cText,
            ),
          );
          return false;
        }
        return true;
      }
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: CustomPage(
          drawerKey: GlobalKeys.drawerKey,
          appbarWidgets: (deviceType == DeviceTypeEnum.desktop)
              ? const AppbarWidgets()
              : null,
          appbarActions: deviceType != DeviceTypeEnum.desktop
              ? [
                  Padding(
                    padding: EdgeInsets.only(
                      right: deviceType == DeviceTypeEnum.mobile
                          ? dimen32
                          : (deviceType == DeviceTypeEnum.tablet)
                              ? dimen72
                              : 0,
                    ),
                    child: IconButton(
                      onPressed: () {
                        GlobalKeys.drawerKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ]
              : null,
          drawer: const DrawerWidget(),
          body: child,

          // ),
        ),
      ),
    );
  }
}
