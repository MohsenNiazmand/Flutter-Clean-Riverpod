import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/login')
  Future<ApiResponse<AuthResponse>> login(
    @Body() Map<String, dynamic> body,
  );

  @POST('/send/activation/token')
  Future<ApiResponse<ActivationTokenResponse>> sendActivationToken(
    @Body() Map<String, dynamic> body,
  );

  @POST('/register')
  Future<ApiResponse<AuthResponse>> register(
    @Body() Map<String, dynamic> body,
  );

  @POST('/send/reset/pass/email')
  Future<ApiResponse<dynamic>> sendResetPasswordEmail(
    @Body() Map<String, dynamic> body,
  );

  @POST('/reset/pass')
  Future<ApiResponse<dynamic>> resetPassword(
      @Body() Map<String, dynamic> body,
      );
}
