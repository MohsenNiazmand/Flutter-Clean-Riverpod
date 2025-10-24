
import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/utils/form_validators.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/message_response.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_pin_put.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/dio.dart';

class CreatePasswordScreen extends HookConsumerWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = useTextEditingController();
    final repeatPasswordController = useTextEditingController();
    final codeController = useTextEditingController();
    final deviceType = context.deviceType;

    final loading =
        ref.watch(resetPasswordProvider).stateChecker ==
        StateCheckerEnum.loading;

    ref.listen<DataState<HttpResponse<MessageResponse>>>(
      resetPasswordProvider,
      (previous, current) {
        if (current is DataSuccess) {
          PrimaryToast.show(
            context.tr.passwordChangeSuccessfully,
            type: ToastTypeEnum.success,
          );
          context.go(Routes.login);
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
                  key: GlobalKeys.createPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          context.tr.createPassword,
                          style: AppStyles()
                              .styleText_14_600()
                              .apply(color: cTextTitle),
                        ),
                      ),
                      Gap.v24(),
                      PrimaryTextField(
                        controller: passwordController,
                        label: context.tr.newPassword,
                        hint: context.tr.passwordHint,
                        name: 'password',
                        obscure: true,
                        isRequired: true,
                        autoValidateMode: AutovalidateMode.disabled,
                        labelPadding: const EdgeInsets.only(bottom: dimen8),
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
                        label: context.tr.repeatPassword,
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
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      Gap.v16(),
                      Text(
                        context.tr.confirmationToken,
                        style: AppStyles().styleText_12_500(),
                      ),
                      Gap.v12(),
                      PrimaryPinPut(
                        controller: codeController,
                        fieldCount: 6,
                        withCursor: true,
                        onSubmit: (v) {},
                      ),
                      Gap.v32(),
                      PrimaryButton(
                        loading: loading,
                        onPress: () {
                          if (GlobalKeys.createPasswordFormKey.currentState
                                  ?.saveAndValidate() ??
                              false) {
                            if (codeController.text.length != 6) {
                              PrimaryToast.show(
                                context.tr.incorrectCodePLeaseCheckAndReEnter,
                              );
                            } else if (passwordController.text ==
                                repeatPasswordController.text) {
                              FocusScope.of(context).unfocus();



                              ref
                                  .read(resetPasswordProvider.notifier)
                                  .resetPassword(
                                    email: ref
                                            .read(
                                              resetEmailProvider.notifier,
                                            )
                                            .state ??
                                        '',
                                    resetToken: codeController.text,
                                    password: passwordController.text,
                                    passwordConfirmation:
                                        repeatPasswordController.text,
                                  );
                            } else {
                              PrimaryToast.show(
                                context.tr.passwordsDoNotMatch,
                              );
                            }
                          }
                        },
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
