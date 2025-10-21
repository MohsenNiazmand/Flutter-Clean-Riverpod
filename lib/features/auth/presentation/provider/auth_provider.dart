import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/send_activation_code_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/send_reset_password_email_usecase.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

final resetEmailProvider = StateProvider<String?>((ref) => null);
final emailRProvider = StateProvider<String?>((ref) => null);
final passwordRProvider = StateProvider<String?>((ref) => null);
final firstNameRProvider = StateProvider<String?>((ref) => null);
final lastNameRProvider = StateProvider<String?>((ref) => null);
final acceptTermsProvider = StateProvider<bool>((ref) => false);
final remainingTimeProvider = StateProvider<int>((ref) => 120);

void clearRegisterFields(WidgetRef ref) {
  ref.read(firstNameRProvider.notifier).state = null;
  ref.read(lastNameRProvider.notifier).state = null;
  ref.read(emailRProvider.notifier).state = null;
  ref.read(passwordRProvider.notifier).state = null;
}

Future<bool> checkLogin() {
  return getIt<SecureStorage>().has(accessTokenKey);
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  DataState<ApiResponse<AuthResponse>> build() {
    return const DataInitial();
  }

  Future<void> login(String email, String password) async {
    try {
      state = const DataLoading();
      final response = await getIt<LoginUseCase>().call(
        params: {'email': email, 'password': password},
      );
      await response.fold((l) {
        state = DataFailed(l);
      }, (r) async {
        await getIt<SecureStorage>().set(accessTokenKey, r.data?.accessToken);
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}

@riverpod
class Register extends _$Register {
  @override
  DataState<ApiResponse<AuthResponse>> build() {
    return const DataInitial();
  }

  Future<void> register(
    String activationToken,
  ) async {
    try {
      final firstName = ref.read(firstNameRProvider.notifier).state;
      final lastName = ref.read(lastNameRProvider.notifier).state;

      final email = ref.read(emailRProvider.notifier).state;
      final password = ref.read(passwordRProvider.notifier).state;
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'activation_token': activationToken,
      };
      state = const DataLoading();
      final response = await getIt<RegisterUseCase>().call(
        params: body,
      );
      await response.fold((l) {
        state = DataFailed(l);
      }, (r) async {
        await getIt<SecureStorage>().set(accessTokenKey, r.data?.accessToken);
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}

@riverpod
class SendActivationToken extends _$SendActivationToken {
  @override
  DataState<ApiResponse<ActivationTokenResponse>> build() {
    return const DataInitial();
  }

  Future<void> sendActivationToken() async {
    try {
      final email = ref.read(emailRProvider.notifier).state;
      state = const DataLoading();
      final response = await getIt<SendActivationTokenUseCase>().call(
        params: email,
      );
      response.fold((l) {
        state = DataFailed(l);
      }, (r) {
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}

@riverpod
class ReSendActivationToken extends _$ReSendActivationToken {
  @override
  DataState<ApiResponse<ActivationTokenResponse>> build() {
    return const DataInitial();
  }

  Future<void> sendActivationToken() async {
    try {
      final email = ref.read(emailRProvider.notifier).state;
      state = const DataLoading();
      final response = await getIt<SendActivationTokenUseCase>().call(
        params: email,
      );
      response.fold((l) {
        state = DataFailed(l);
      }, (r) {
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}

@riverpod
class SendResetPasswordEmail extends _$SendResetPasswordEmail {
  @override
  DataState<ApiResponse<dynamic>> build() {
    return const DataInitial();
  }

  Future<void> sendResetPasswordEmail(String email) async {
    try {
      state = const DataLoading();
      final response = await getIt<SendResetPasswordEmailUseCase>().call(
        params: email,
      );
      response.fold((l) {
        state = DataFailed(l);
      }, (r) {
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}

@riverpod
class ResetPassword extends _$ResetPassword {
  @override
  DataState<ApiResponse<dynamic>> build() {
    return const DataInitial();
  }

  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      state = const DataLoading();
      final response = await getIt<ResetPasswordUseCase>().call(
        params: {
          'email': email,
          'reset_token': resetToken,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      response.fold((l) {
        state = DataFailed(l);
      }, (r) {
        state = DataSuccess(r);
      });
    } catch (e) {
      state = DataFailed(ExceptionHandler());
      LoggerHelper.errorLog(e);
    }
  }
}
