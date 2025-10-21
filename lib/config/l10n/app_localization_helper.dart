import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/l10n/app_localizations.dart';

extension AppLocalizationHelper on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}