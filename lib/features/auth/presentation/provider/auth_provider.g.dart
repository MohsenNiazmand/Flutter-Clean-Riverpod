// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginNotifierHash() => r'853947792d926e7b91e23e586cf58aeb796409cd';

/// See also [LoginNotifier].
@ProviderFor(LoginNotifier)
final loginNotifierProvider = AutoDisposeNotifierProvider<LoginNotifier,
    DataState<HttpResponse<AuthResponse>>>.internal(
  LoginNotifier.new,
  name: r'loginNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginNotifier
    = AutoDisposeNotifier<DataState<HttpResponse<AuthResponse>>>;
String _$registerHash() => r'eab0720b6619c9ba360c62e68a9330f4dd44b0bc';

/// See also [Register].
@ProviderFor(Register)
final registerProvider = AutoDisposeNotifierProvider<Register,
    DataState<HttpResponse<AuthResponse>>>.internal(
  Register.new,
  name: r'registerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$registerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Register = AutoDisposeNotifier<DataState<HttpResponse<AuthResponse>>>;
String _$sendActivationTokenHash() =>
    r'6f2f001dd1c47c5197abdeb5519bfbe7ed316e9c';

/// See also [SendActivationToken].
@ProviderFor(SendActivationToken)
final sendActivationTokenProvider = AutoDisposeNotifierProvider<
    SendActivationToken,
    DataState<HttpResponse<ActivationTokenResponse>>>.internal(
  SendActivationToken.new,
  name: r'sendActivationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendActivationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendActivationToken
    = AutoDisposeNotifier<DataState<HttpResponse<ActivationTokenResponse>>>;
String _$reSendActivationTokenHash() =>
    r'93ff016150c609f3fc6d44b163568a9d40652c26';

/// See also [ReSendActivationToken].
@ProviderFor(ReSendActivationToken)
final reSendActivationTokenProvider = AutoDisposeNotifierProvider<
    ReSendActivationToken,
    DataState<HttpResponse<ActivationTokenResponse>>>.internal(
  ReSendActivationToken.new,
  name: r'reSendActivationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reSendActivationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReSendActivationToken
    = AutoDisposeNotifier<DataState<HttpResponse<ActivationTokenResponse>>>;
String _$sendResetPasswordEmailHash() =>
    r'5c05869b10469e963080870a828c7c551f2b3b45';

/// See also [SendResetPasswordEmail].
@ProviderFor(SendResetPasswordEmail)
final sendResetPasswordEmailProvider = AutoDisposeNotifierProvider<
    SendResetPasswordEmail,
    DataState<HttpResponse<ResetPasswordResponse>>>.internal(
  SendResetPasswordEmail.new,
  name: r'sendResetPasswordEmailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendResetPasswordEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendResetPasswordEmail
    = AutoDisposeNotifier<DataState<HttpResponse<ResetPasswordResponse>>>;
String _$resetPasswordHash() => r'24475a7afd5bbdde2b7668a06ab5098c87490deb';

/// See also [ResetPassword].
@ProviderFor(ResetPassword)
final resetPasswordProvider = AutoDisposeNotifierProvider<ResetPassword,
    DataState<HttpResponse<MessageResponse>>>.internal(
  ResetPassword.new,
  name: r'resetPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResetPassword
    = AutoDisposeNotifier<DataState<HttpResponse<MessageResponse>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
