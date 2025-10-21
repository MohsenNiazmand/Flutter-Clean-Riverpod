import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/shared/data/model/post_model.dart';
import 'package:flutter_clean_riverpod/shared/presentation/my_app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // Use path URL strategy for Flutter web (removes hash from URLs)
  usePathUrlStrategy();
  // Keep imperative navigation APIs in sync with the URL
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  AndroidOptions getAndroidOptions() => AndroidOptions.defaultOptions;
  await initializeDependencies(
    androidOptions: getAndroidOptions(),
  );
  tz.initializeTimeZones();
  await valuateTokenGlobalKeys();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Reads persisted access token and stores it in [Constants.appToken]
Future<void> valuateTokenGlobalKeys() async {
  Constants.appToken = await getIt<SecureStorage>().get(accessTokenKey);
}
