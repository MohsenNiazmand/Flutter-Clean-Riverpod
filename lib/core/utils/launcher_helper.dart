import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility for launching URLs and email addresses.
/// Handles both external applications and in-app web views.
class LauncherHelper {
  static Future<bool> _canLaunchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      return true;
    } else {
      LoggerHelper.logger.e('Could not launch');
      return false;
    }
  }

  static Future<void> launch(String? link, {bool inAppWebView = false}) async {
    try {
      if (link != null || link!.isNotEmpty) {
        final uri = Uri.parse(link);
        if (await _canLaunchURL(uri)) {
          await launchUrl(
            uri,
            mode: inAppWebView
                ? LaunchMode.inAppWebView
                : LaunchMode.externalApplication,
          );
        }
      } else {
        LoggerHelper.logger.e('Link have problem');
      }
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }
  static Future<void> launchEmail(String? emailAddress) async {
    try {
      if (emailAddress != null || emailAddress!.isNotEmpty) {
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: emailAddress,
        );
        launchUrl(emailLaunchUri);
      } else {
        LoggerHelper.logger.e('Link have problem');
      }
    } catch (e) {
      LoggerHelper.errorLog(e);
    }
  }
}
