// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginNotifierHash() => r'a3f2e42540ec3ea3c3a5e9ab01ba3d8969a8f40d';

/// See also [LoginNotifier].
@ProviderFor(LoginNotifier)
final loginNotifierProvider = AutoDisposeNotifierProvider<LoginNotifier,
    DataState<ApiResponse<AuthResponse>>>.internal(
  LoginNotifier.new,
  name: r'loginNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginNotifier
    = AutoDisposeNotifier<DataState<ApiResponse<AuthResponse>>>;
String _$registerHash() => r'5e7a63448d1cacb5066e69069354d61484e4860e';

/// See also [Register].
@ProviderFor(Register)
final registerProvider = AutoDisposeNotifierProvider<Register,
    DataState<ApiResponse<AuthResponse>>>.internal(
  Register.new,
  name: r'registerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$registerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Register = AutoDisposeNotifier<DataState<ApiResponse<AuthResponse>>>;
String _$sendActivationTokenHash() =>
    r'ec0f6769dabe34aee4810a03f9a52605833534da';

/// See also [SendActivationToken].
@ProviderFor(SendActivationToken)
final sendActivationTokenProvider = AutoDisposeNotifierProvider<
    SendActivationToken,
    DataState<ApiResponse<ActivationTokenResponse>>>.internal(
  SendActivationToken.new,
  name: r'sendActivationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendActivationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendActivationToken
    = AutoDisposeNotifier<DataState<ApiResponse<ActivationTokenResponse>>>;
String _$reSendActivationTokenHash() =>
    r'6ca35bfe52538e6242080d2af212e7f1d9c6b398';

/// See also [ReSendActivationToken].
@ProviderFor(ReSendActivationToken)
final reSendActivationTokenProvider = AutoDisposeNotifierProvider<
    ReSendActivationToken,
    DataState<ApiResponse<ActivationTokenResponse>>>.internal(
  ReSendActivationToken.new,
  name: r'reSendActivationTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reSendActivationTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReSendActivationToken
    = AutoDisposeNotifier<DataState<ApiResponse<ActivationTokenResponse>>>;
String _$sendResetPasswordEmailHash() =>
    r'f71b75d6e4d42035f5de647517b4eac00f8e204b';

/// See also [SendResetPasswordEmail].
@ProviderFor(SendResetPasswordEmail)
final sendResetPasswordEmailProvider = AutoDisposeNotifierProvider<
    SendResetPasswordEmail, DataState<ApiResponse<dynamic>>>.internal(
  SendResetPasswordEmail.new,
  name: r'sendResetPasswordEmailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendResetPasswordEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendResetPasswordEmail
    = AutoDisposeNotifier<DataState<ApiResponse<dynamic>>>;
String _$resetPasswordHash() => r'02b04034f3091ca217e596879de71fd88704a059';

/// See also [ResetPassword].
@ProviderFor(ResetPassword)
final resetPasswordProvider = AutoDisposeNotifierProvider<ResetPassword,
    DataState<ApiResponse<dynamic>>>.internal(
  ResetPassword.new,
  name: r'resetPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResetPassword = AutoDisposeNotifier<DataState<ApiResponse<dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
