import 'dart:math';
import 'package:flutter_clean_riverpod/shared/presentation/captcha/captcha_box.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_dialog.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CaptchaDialog extends HookConsumerWidget {
  const CaptchaDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInput = useState<String>('');
    final loading = useState(false);
    String generateCaptcha() {
      const characters =
          'ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789';
      return List.generate(
        6,
        (index) => characters[Random().nextInt(characters.length)],
      ).join();
    }

    final captchaText = useState<String>(generateCaptcha());

    void validateCaptcha() {
      if (GlobalKeys.captchaDialogFormKey.currentState?.saveAndValidate() ??
          false) {
        if (userInput.value.toUpperCase() == captchaText.value.toUpperCase()) {
          loading.value = true;
          Future.delayed(Durations.medium3, () {
            if (context.mounted) {
              Navigator.pop(context, true);
            }
          });
        } else {
          PrimaryToast.show('Wrong Captcha!');
        }
      }
    }

    return PrimaryDialog(
      title: const Text(''),
      width: 400,
      height: 280,
      child: PrimaryRectangle(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              FormBuilder(
                key: GlobalKeys.captchaDialogFormKey,
                child: PrimaryTextField(
                  isRequired: true,
                  onChanged: (value) {
                    userInput.value = value ?? '';
                  },
                  hint: 'Enter CAPTCHA text',
                  name: 'captcha',
                ),
              ),
              const Expanded(child: SizedBox(height: 20)),
              PrimaryButton(
                loading: loading.value,
                onPress: validateCaptcha,
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
