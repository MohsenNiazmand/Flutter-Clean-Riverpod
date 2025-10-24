import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/utils/form_validators.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/captcha/captcha_widget.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_checkbox.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/dio.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    final lastNameFocus = useFocusNode();

    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();
    final acceptTerms = ref.watch(acceptTermsProvider);
    final isCaptchaValidate = useState(false);

    final loading = ref.watch(sendActivationTokenProvider).stateChecker ==
        StateCheckerEnum.loading;

    Future<void> register() async {
      final firstName = GlobalKeys.registerFormKey.currentState
          ?.fields[context.tr.firstName]?.value as String?;
      final lastName = GlobalKeys.registerFormKey.currentState
          ?.fields[context.tr.lastName]?.value as String?;
      final email = GlobalKeys
          .registerFormKey.currentState?.fields['email']?.value as String?;

      final password = GlobalKeys
          .registerFormKey.currentState?.fields['password']?.value as String?;
      final repeatPassword = GlobalKeys.registerFormKey.currentState
          ?.fields['repeatPassword']?.value as String?;

      if (GlobalKeys.registerFormKey.currentState?.saveAndValidate() ?? false) {
        if (!acceptTerms) {
          PrimaryToast.show(
            context.tr.youShouldAcceptTermsToContinue,
          );
          return;
        }
        if (password != repeatPassword) {
          PrimaryToast.show(
            context.tr.passwordsDoNotMatch,
          );
          return;
        }
        if (!isCaptchaValidate.value) {
          PrimaryToast.show(context.tr.invalidCaptcha);
          GlobalKeys.registerFormKey.currentState?.fields[context.tr.captcha]
              ?.didChange('');
          return;
        }

        if (isCaptchaValidate.value) {
          ref.read(firstNameRProvider.notifier).state = firstName;
          ref.read(lastNameRProvider.notifier).state = lastName;
          ref.read(emailRProvider.notifier).state = email;
          ref.read(passwordRProvider.notifier).state = password;

          unawaited(
            ref
                .read(sendActivationTokenProvider.notifier)
                .sendActivationToken(),
          );
        }
      }
    }

    ref.listen<DataState<HttpResponse<ActivationTokenResponse?>>>(
      sendActivationTokenProvider,
      (previous, current) {
        if (current is DataSuccess) {
          context.push(Routes.emailConfirmation);
        }
      },
    );

    return CustomPage(
      loading: loading,
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
                  key: GlobalKeys.registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          context.tr.createAccount,
                          style: AppStyles()
                              .styleText_14_600()
                              .apply(color: cTextTitle),
                        ),
                      ),
                      Gap.v24(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              label: context.tr.firstName,
                              name: context.tr.firstName,
                              isRequired: true,
                              labelPadding:
                                  const EdgeInsets.only(bottom: dimen8),
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(lastNameFocus);
                              },
                            ),
                          ),
                          Gap.h16(),
                          Expanded(
                            child: PrimaryTextField(
                              label: context.tr.lastName,
                              name: context.tr.lastName,
                              isRequired: true,
                              labelPadding:
                                  const EdgeInsets.only(bottom: dimen8),
                              focusNode: lastNameFocus,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap.v16(),
                      PrimaryTextField(
                        label: context.tr.email,
                        name: 'email',
                        isRequired: true,
                        keyboardType: TextInputType.emailAddress,
                        autoValidateMode: AutovalidateMode.disabled,
                        validators: [FormBuilderValidators.email()],
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      Gap.v16(),
                      PrimaryTextField(
                        controller: passwordController,
                        label: context.tr.password,
                        hint: context.tr.passwordHint,
                        name: 'password',
                        obscure: true,
                        isRequired: true,
                        autoValidateMode: AutovalidateMode.disabled,
                        validators: [
                          FormValidators.minLength(
                            context,
                            8,
                            errorText: context.tr.passwordInvalid,
                          ),
                          FormValidators.passwordValidator(context),
                        ],
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      Gap.v16(),
                      PrimaryTextField(
                        controller: repeatPasswordController,
                        label: context.tr.confirmPassword,
                        hint: context.tr.passwordHint,
                        name: 'repeatPassword',
                        obscure: true,
                        isRequired: true,
                        autoValidateMode: AutovalidateMode.disabled,
                        validators: [
                          FormValidators.minLength(
                            context,
                            8,
                            errorText: context.tr.passwordInvalid,
                          ),
                          FormValidators.passwordValidator(context),
                        ],
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      Gap.v16(),
                      PrimaryCheckbox(
                        text: context.tr.acceptTermsAndConditions,
                        value: acceptTerms,
                        onChanged: () {
                          ref.read(acceptTermsProvider.notifier).state =
                              !acceptTerms;
                        },
                      ),
                      Gap.v32(),
                      CaptchaWidget(
                        onEditingComplete: register,
                        onCaptchaValidated: (r) {
                          isCaptchaValidate.value = r;
                        },
                      ),
                      Gap.v32(),
                      PrimaryButton(
                        onPress: register,
                        text: context.tr.continueText,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Gap.v16(),
                      Row(
                        children: [
                          Text(
                            context.tr.doYouHaveAnAccount,
                            style: AppStyles().styleText_12_500(),
                          ),
                          Gap.h4(),
                          TextButton(
                            onPressed: () {
                              context.go(Routes.login);
                            },
                            child: Text(
                              context.tr.login,
                              style: AppStyles()
                                  .styleText_12_600()
                                  .apply(color: cPrimary),
                            ),
                          ),
                        ],
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
