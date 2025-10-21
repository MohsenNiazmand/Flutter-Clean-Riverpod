import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/core/utils/form_validators.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;

    final loginLoading = useState(false);

    Future<void> login() async {
      if (GlobalKeys.loginFormKey.currentState?.saveAndValidate() ?? false) {
        FocusScope.of(context).unfocus();
        final email = GlobalKeys
            .loginFormKey.currentState?.fields['username']?.value as String;
        final password = GlobalKeys
            .loginFormKey.currentState?.fields['password']?.value as String;
        //In reality we use this, but now we simulate real process
        // await ref.read(loginNotifierProvider.notifier).login(email, password);

        loginLoading.value = true;
        Future.delayed(Durations.extralong4, () async {
          loginLoading.value = false;
          await getIt<SecureStorage>().set(accessTokenKey, 'TestToken');
          if (context.mounted) {
            context.go(Routes.home);
          }
        });
      }
    }

    final version = useState('1');
    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          // final PackageInfo packageInfo = await PackageInfo.fromPlatform();
          // version.value = packageInfo.version;
        });
        return null;
      },
      [],
    );

    // ref.listen<DataState<ApiResponse<AuthResponse?>>>(
    //   loginNotifierProvider,
    //       (previous, current) {
    //     if (current is DataSuccess) {
    //         context.go(Routes.home);
    //     }
    //   },
    // );

    return AnimatedSwitcher(
      duration: Durations.short3,
      child: CustomPage(
        key: const Key('login'),
        loading: loginLoading.value,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: dimen32),
            child: Column(
              children: [
                Gap.custom(
                  height: (deviceType != DeviceTypeEnum.mobile)
                      ? dimen120
                      : dimen100,
                ),
                PrimaryRectangle(
                  width: (deviceType != DeviceTypeEnum.mobile)
                      ? dimen512
                      : MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(dimen24),
                  radius: dimen8,
                  child: FormBuilder(
                    key: GlobalKeys.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            context.tr.loginToAccount,
                            style: AppStyles()
                                .styleText_14_600()
                                .apply(color: cTextTitle),
                          ),
                        ),
                        Gap.v24(),
                        PrimaryTextField(
                          label: context.tr.email,
                          hint: context.tr.emailAddress,
                          name: 'username',
                          isRequired: true,
                          keyboardType: TextInputType.emailAddress,
                          autoValidateMode: AutovalidateMode.disabled,
                          autofillHints: const [AutofillHints.username],
                          validators: [FormBuilderValidators.email()],
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        Gap.v16(),
                        PrimaryTextField(
                          label: context.tr.password,
                          hint: context.tr.passwordHint,
                          name: 'password',
                          obscure: true,
                          isRequired: true,
                          autoValidateMode: AutovalidateMode.disabled,
                          autofillHints: const [AutofillHints.password],
                          validators: [
                            FormValidators.minLength(
                              context,
                              8,
                              errorText: context.tr.passwordInvalid,
                            ),
                          ],
                          onEditingComplete: login,
                        ),
                        Gap.v12(),
                        TextButton(
                          focusNode: FocusNode(canRequestFocus: false),
                          onPressed: () {
                            context.push(Routes.forgotPassword);
                          },
                          child: Text(
                            context.tr.iForgotMyPassword,
                            style: AppStyles().styleText_12_500(),
                          ),
                        ),
                        Gap.v32(),
                        PrimaryButton(
                          loading: loginLoading.value,
                          onPress: login,
                          text: context.tr.login,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                        Gap.v16(),
                        Row(
                          children: [
                            Text(
                              context.tr.doNotHaveAnAccount,
                              style: AppStyles().styleText_12_500(),
                            ),
                            Gap.h4(),
                            TextButton(
                              onPressed: () {
                                context.go(Routes.register);
                              },
                              child: Text(
                                context.tr.register,
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
                Gap.v24(),
                if (!kIsWeb)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.tr.byLoggingInYouAgreeToOur,
                          style: AppStyles().styleText_14_400(),
                        ),
                        TextSpan(
                          text: '${context.tr.privacyPolicy} !',
                          style: AppStyles()
                              .styleText_14_600()
                              .apply(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // context.push(Routes.privacyPolicy);
                            },
                        ),
                      ],
                    ),
                  ),
                Gap.v32(),
                Text(
                  'v ${version.value}',
                  style: AppStyles().styleText_12_500(),
                ),
                Gap.v32(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
