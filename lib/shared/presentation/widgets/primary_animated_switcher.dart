import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/material.dart';

class PrimaryAnimatedSwitcher extends StatelessWidget {

  const PrimaryAnimatedSwitcher(
      {required this.stateCheckerEnum, super.key,
      this.child,
      this.loading,
      this.failed,
      this.initial,
      this.duration,
      });
  final StateCheckerEnum? stateCheckerEnum;
  final Widget? child;
  final Widget? loading;
  final Widget? failed;
  final Widget? initial;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: duration ?? Durations.medium2,
      child:
      (stateCheckerEnum == StateCheckerEnum.loading)
          ? loading
          : (stateCheckerEnum == StateCheckerEnum.failed)
              ? failed
              : (stateCheckerEnum == StateCheckerEnum.done)
                  ? child
                  : initial ?? loading,
    );
  }
}
