import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: cPrimary,
    highlightColor: Colors.transparent,
    canvasColor: cBackground,
    scaffoldBackgroundColor: cWhite,
    shadowColor: cShadow,
    hintColor: cTextHint,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: cPrimary),
    dividerColor: cBorder,
    scrollbarTheme:
        const ScrollbarThemeData(thumbColor: WidgetStatePropertyAll(cGrey)),
  );
}
