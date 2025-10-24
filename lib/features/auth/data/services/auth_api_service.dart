import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/message_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/reset_password_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('users/login/')
  Future<HttpResponse<AuthResponse>> login(
    @Body() Map<String, dynamic> body,
  );

  @POST('users/send-activation-code/')
  Future<HttpResponse<ActivationTokenResponse>> sendActivationToken(
    @Body() Map<String, dynamic> body,
  );

  @POST('users/register-with-activation/')
  Future<HttpResponse<AuthResponse>> register(
    @Body() Map<String, dynamic> body,
  );

  @POST('users/send-reset-password-email/')
  Future<HttpResponse<ResetPasswordResponse>> sendResetPasswordEmail(
    @Body() Map<String, dynamic> body,
  );

  @POST('users/reset-password/')
  Future<HttpResponse<MessageResponse>> resetPassword(
    @Body() Map<String, dynamic> body,
  );
}
