import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter/material.dart';

class PrimaryToast {
  static CancelFunc? cancelFunc;

  static void show(String? text,
      {ToastTypeEnum type = ToastTypeEnum.error,
      Duration? duration,
      double? bottomMargin}) {
    if (cancelFunc != null) {
      cancelFunc!.call();
    }
    cancelFunc = BotToast.showCustomText(
      duration: duration ?? getDuration(text),
      align: Alignment.bottomCenter,
      toastBuilder: (_) => Builder(
        builder: (BuildContext context) {
          late Color background;
          late Color textColor;
          late Color iconColor;
          late Widget icon;

          switch (type) {
            case ToastTypeEnum.error:
              background = cError50;
              textColor = cErrorDark;
              iconColor = cError;
              icon = Icon(
                Icons.warning_rounded,
                color: iconColor,
              );
            case ToastTypeEnum.success:
              background = cSuccess50;
              textColor = cSuccessDark;
              iconColor = cSuccess;
              icon = Icon(
                Icons.check_circle_rounded,
                color: iconColor,
              );
            case ToastTypeEnum.info:
              background = const Color(0xFFFDF5E7);
              textColor = const Color(0xFFC27C13);
              iconColor = const Color(0xFFF19A17);
              icon = Icon(
                Icons.info_outline_rounded,
                color: iconColor,
              );
          }

          final screenWidth = MediaQuery.of(context).size.width;

          return GestureDetector(
            onTap: getDuration(text).inMilliseconds > 3000
                ? () {
                    if (cancelFunc != null) {
                      cancelFunc!.call();
                    }
                  }
                : null,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                dimen20,
                0,
                dimen20,
                bottomMargin ?? dimen32,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: iconColor),
                color: background,
              ),
              child: SizedBox(
                width: (screenWidth > 600)
                    ? 400
                    : MediaQuery.sizeOf(context).width,
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 12),
                    child: Row(
                      children: <Widget>[
                        icon,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              text ?? '',
                              textAlign: TextAlign.start,
                              style: AppStyles()
                                  .styleText_12_500()
                                  .apply(color: textColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      wrapToastAnimation:
          (AnimationController controller, CancelFunc cancel, Widget child) =>
              _CustomAnimationWidget(
        controller: controller,
        child: child,
      ),
    );
  }

  static Duration getDuration(String? text) {
    int milliseconds = (text?.length ?? 0) * 48;
    milliseconds = milliseconds < 2000 ? 2000 : milliseconds;
    milliseconds = milliseconds > 6000 ? 6000 : milliseconds;
    return Duration(milliseconds: milliseconds);
  }
}

class _CustomAnimationWidget extends StatefulWidget {
  const _CustomAnimationWidget({required this.controller, required this.child});

  final AnimationController controller;
  final Widget child;

  @override
  _CustomAnimationWidgetState createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<_CustomAnimationWidget> {
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );

  static final Tween<double> tweenScale = Tween<double>(begin: 0.7, end: 1);
  late Animation<double> animation;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          offset: tweenOffset.evaluate(animation),
          child: Transform.scale(
            scale: tweenScale.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          ),
        ),
        child: widget.child,
      );
}
