import 'dart:math';

import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/shared/presentation/captcha/captcha_box.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CaptchaWidget extends HookConsumerWidget {
  const CaptchaWidget({
    required this.onEditingComplete,
    required this.onCaptchaValidated,
    super.key,
  });

  final Function(bool) onCaptchaValidated;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInput = useState<String>('');
    String generateCaptcha() {
      const characters =
          'ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789';
      return List.generate(
        6,
        (index) => characters[Random().nextInt(characters.length)],
      ).join();
    }

    final captchaText = useState<String>(generateCaptcha());

    void validateCaptcha(String value) {
      final isValid = value.toUpperCase() == captchaText.value.toUpperCase();
      onCaptchaValidated(isValid);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CaptchaBox(captchaText.value),
            ),
            Gap.h16(),
            InkWell(
              onTap: () {
                captchaText.value = generateCaptcha();
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          isRequired: true,
          maxLength: 6,
          onEditingComplete: onEditingComplete,
          onChanged: (value) {
            userInput.value = value ?? '';
            validateCaptcha(userInput.value);
          },
          hint: 'Enter CAPTCHA text',
          name: context.tr.captcha,
        ),
      ],
    );
  }
}
