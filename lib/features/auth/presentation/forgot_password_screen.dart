import 'dart:async';

import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/captcha/captcha_widget.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final loading = useState(false);
        // ref.watch(sendResetPasswordEmailProvider).stateChecker ==
        // StateCheckerEnum.loading;
    final isCaptchaValidate = useState(false);

    // ref.listen<DataState<ApiResponse<dynamic>>>(
    //   sendResetPasswordEmailProvider,
    //   (previous, current) {
    //     if (current is DataSuccess) {
    //       PrimaryToast.show(
    //         context.tr.passwordResetCodeSentPleaseCheckYourEmail,
    //         type: ToastTypeEnum.success,
    //       );
    //       context.push(Routes.createPassword);
    //     }
    //   },
    // );

    Future<void> submit() async {
      if (GlobalKeys.forgotPasswordFormKey.currentState?.saveAndValidate() ??
          false) {

        if (!isCaptchaValidate.value) {
          PrimaryToast.show(context.tr.invalidCaptcha);
          GlobalKeys
              .forgotPasswordFormKey.currentState?.fields[context.tr.captcha]
              ?.didChange('');
          return;
        }
        FocusScope.of(context).unfocus();
        final email = GlobalKeys.forgotPasswordFormKey.currentState
            ?.fields['email']?.value as String;
        ref.read(resetEmailProvider.notifier).state = email;


        // unawaited(ref
        //     .read(sendResetPasswordEmailProvider.notifier)
        //     .sendResetPasswordEmail(email));

        loading.value = true;
        Future.delayed(Durations.extralong4, () {
          loading.value = false;
          if (context.mounted) {
            context.go(Routes.createPassword);
          }
        });
      }
    }

    return CustomPage(
      loading: loading.value,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimen32),
          child: Column(
            children: [
              Gap.custom(
                height:
                    (deviceType != DeviceTypeEnum.mobile) ? dimen120 : dimen100,
              ),
              PrimaryRectangle(
                width: (deviceType != DeviceTypeEnum.mobile)
                    ? dimen512
                    : MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(dimen24),
                radius: dimen8,
                child: FormBuilder(
                  key: GlobalKeys.forgotPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              context.tr.resetPassword,
                              style: AppStyles()
                                  .styleText_14_600()
                                  .apply(color: cTextTitle),
                            ),
                            Gap.v8(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    (deviceType != DeviceTypeEnum.mobile)
                                        ? dimen80
                                        : dimen32,
                              ),
                              child: Text(
                                context.tr.resetPasswordDescription,
                                textAlign: TextAlign.center,
                                style: AppStyles().styleText_11_400(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap.v24(),
                      PrimaryTextField(
                        label: context.tr.email,
                        hint: context.tr.emailExample,
                        name: 'email',
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                        autoValidateMode: AutovalidateMode.disabled,
                        validators: [FormBuilderValidators.email()],
                      ),
                      Gap.v32(),
                      CaptchaWidget(
                          onEditingComplete: submit,
                          onCaptchaValidated: (r) {
                            isCaptchaValidate.value = r;
                          }),
                      Gap.v32(),
                      PrimaryButton(
                        loading: loading.value,
                        onPress: submit,
                        text: context.tr.confirm,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    ],
                  ),
                ),
              ),
              Gap.v32(),
            ],
          ),
        ),
      ),
    );
  }
}
