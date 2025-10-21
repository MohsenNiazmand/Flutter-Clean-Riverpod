import 'dart:async';

import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
// import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrimaryCountDownTimer extends HookConsumerWidget {
  const PrimaryCountDownTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(remainingTimeProvider);
    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingTime > 0) {
            ref.read(remainingTimeProvider.notifier).state--;
          } else {
            timer.cancel();
          }
        });
        return timer.cancel;
      },
      [remainingTime],
    );

    String formatTime(int seconds) {
      final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
      final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
      return '$minutes:$remainingSeconds';
    }

    return Text(
      formatTime(remainingTime),
      style: AppStyles().styleText_11_400().apply(color: cPrimary),
    );
  }
}
