import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/l10n/app_localizations.dart';
import 'package:flutter_clean_riverpod/config/routes/app_router.dart';
import 'package:flutter_clean_riverpod/config/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends HookConsumerWidget {
  MyApp({super.key});

  final _appRouter = AppRouter().router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final botToastBuilder = BotToastInit();

    return MaterialApp.router(
        scrollBehavior:const MaterialScrollBehavior().copyWith(
      dragDevices: {PointerDeviceKind.mouse,PointerDeviceKind.touch,},) ,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter,
      builder: botToastBuilder,
    );
  }
}
