import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/extensions/device_type_extension.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:flutter_clean_riverpod/shared/presentation/global_keys.dart';
import 'package:flutter_clean_riverpod/shared/presentation/screens/custom_page.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_button.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_countdown_timer.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_gap.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_pin_put.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailConfirmationScreen extends HookConsumerWidget {
  const EmailConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinPutWidth = useState(0.0);
    final deviceType = context.deviceType;
    final codeController = useTextEditingController();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final RenderBox renderBox = GlobalKeys
              .pinPutEmailConfirmationKey.currentContext!
              .findRenderObject()! as RenderBox;
          pinPutWidth.value = renderBox.size.width;
        });
        return null;
      },
    );

    final loading = useState(false);
    // ref.watch(registerProvider).stateChecker == StateCheckerEnum.loading;

    final resendLoading = useState(false);
    // ref.watch(reSendActivationTokenProvider).stateChecker ==
    //     StateCheckerEnum.loading;


    // ref..listen<DataState<ApiResponse<AuthResponse?>>>(
    //   registerProvider,
    //       (previous, current) {
    //     if (current is DataSuccess) {
    //       clearRegisterFields(ref);
    //       context.go(Routes.home);
    //     }
    //   },
    // )
    // ..listen<DataState<ApiResponse<ActivationTokenResponse?>>>(
    //   reSendActivationTokenProvider,
    //   (previous, current) {
    //     if (current is DataSuccess) {
    //       ref.read(remainingTimeProvider.notifier).state = 120;
    //     }
    //   },
    // );
    final interestedEmail = ref.watch(emailRProvider);
    return CustomPage(
      loading: loading.value || resendLoading.value,
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
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            context.tr.emailConfirmation,
                            style: AppStyles()
                                .styleText_14_600()
                                .apply(color: cTextTitle),
                          ),
                          Gap.v8(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: (deviceType != DeviceTypeEnum.mobile)
                                  ? dimen80
                                  : dimen32,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              context.tr.emailVerificationDescription(
                                interestedEmail ?? '',
                              ),
                              style: AppStyles().styleText_11_400(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap.v24(),
                    PrimaryPinPut(
                      controller: codeController,
                      key: GlobalKeys.pinPutEmailConfirmationKey,
                      fieldCount: 6,
                      withCursor: true,
                      onSubmit: (v) {},
                    ),
                    Gap.v8(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const PrimaryCountDownTimer(),
                        Gap.h4(),
                        Text(
                          context.tr.toResend,
                          style: AppStyles().styleText_11_400(),
                        ),
                      ],
                    ),
                    Gap.v12(),
                    SizedBox(
                      width: pinPutWidth.value > 0 ? pinPutWidth.value : null,
                      // Set the width of PrimaryPinPut
                      child: PrimaryButton(
                        onPress: () {
                          if (codeController.text.length != 6) {
                            PrimaryToast.show(
                              context.tr.incorrectCodePLeaseCheckAndReEnter,
                            );
                          } else {
                            //In reality we use this, but now we simulate real process.
                            // ref
                            //     .read(registerProvider.notifier)
                            //     .register(codeController.text);

                            loading.value = true;
                            Future.delayed(Durations.extralong4, () async {
                              loading.value = false;
                                await getIt<SecureStorage>().set(accessTokenKey, 'TestToken');
                              if (context.mounted) {
                                context.go(Routes.home);
                              }
                            });
                          }
                        },
                        text: context.tr.confirmCode,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    ),
                    Gap.v16(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.tr.didNotReceiveCode,
                          style: AppStyles().styleText_12_500(),
                        ),
                        Gap.h4(),
                        TextButton(
                          onPressed: () {
                            final remainedTime =
                                ref.read(remainingTimeProvider.notifier).state;
                            if (remainedTime == 0) {
                              //In reality we use this, but now we simulate real process.

                              // ref
                              //     .read(
                              //       reSendActivationTokenProvider.notifier,
                              //     )
                              //     .sendActivationToken();

                              resendLoading.value = true;
                              Future.delayed(Durations.extralong4, () {
                                resendLoading.value = false;
                                ref.read(remainingTimeProvider.notifier).state =
                                    120;
                              });
                            }
                          },
                          child: Text(
                            context.tr.resend,
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
              Gap.v32(),
            ],
          ),
        ),
      ),
    );
  }
}
