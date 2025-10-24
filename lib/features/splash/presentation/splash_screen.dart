import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
          () {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

          if (Constants.appToken!=null) {
            context.go(Routes.notes);
          } else {
            context.go(Routes.login);
          }
        });
        return null;
      },
      [],
    );

    return const SizedBox.shrink();
  }
}
