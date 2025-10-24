import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/core/constants/assets.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/main_screen_provider.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomPage extends HookConsumerWidget {
  const CustomPage({
    required this.body,
    this.appbarActions,
    this.drawerKey,
    this.drawer,
    this.appbarWidgets,
    this.loading = false,
    super.key,
  });

  final Widget body;
  final List<Widget>? appbarActions;
  final Widget? appbarWidgets;
  final GlobalKey<ScaffoldState>? drawerKey;
  final Widget? drawer;
  final bool loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final isLoggedIn = useState(false);

    Future<void> checkLoginStatus() async {
      final result = await checkLogin();
      isLoggedIn.value = result;
    }

    useEffect(
      () {
        checkLoginStatus();
        return null;
      },
      [],
    );
    return Scaffold(
      key: drawerKey,
      backgroundColor: cBackground,
      drawer: drawer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cWhite,
        surfaceTintColor: cWhite,
        elevation: dimen6,
        shadowColor: cShadow,
        toolbarHeight: deviceType == DeviceTypeEnum.mobile
            ? dimen56
            : deviceType == DeviceTypeEnum.tablet
                ? dimen64
                : dimen80,
        title: Container(
          padding: EdgeInsets.symmetric(
            vertical: dimen24,
            horizontal:
                (deviceType == DeviceTypeEnum.desktop) ? dimen176 : dimen32,
          ),
          child: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (isLoggedIn.value) {
                    getIt<SecureStorage>()
                        .set(currentLocationWeb, Routes.notes);
                    ref.read(currentLocationProvider.notifier).state =
                        Routes.notes;
                    context.go(Routes.notes);
                  } else {
                    context.go(Routes.notes);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: dimen12),
                  child: FlutterLogo(
                    style: FlutterLogoStyle.horizontal, // Options: stacked, horizontal, mark_only
                    textColor: Colors.blue,
                    size: deviceType == DeviceTypeEnum.mobile ? 100 : 120,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
               appbarWidgets ?? const SizedBox(),
            ],
          ),
        ),
        actions: appbarActions,
      ),
      body: Stack(
        children: [
          Align(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: body,
            ),
          ),
          if (loading)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
