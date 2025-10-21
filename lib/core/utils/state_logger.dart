import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Riverpod state observer for debugging provider state changes.
/// Logs when providers update with old and new values.
class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    LoggerHelper.logger.w('''
    {
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}
    ''');
  }
}