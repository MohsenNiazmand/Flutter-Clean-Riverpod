import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/message_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/reset_password_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/services/auth_api_service.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:retrofit/dio.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(
    this._apiService,
  );

  final AuthApiService _apiService;

  @override
  Future<Either<ExceptionHandler, HttpResponse<AuthResponse>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email, 'password': password};
      final result = await _apiService.login(body);
      if (result.response.statusCode == 200) {

        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<ActivationTokenResponse>>>
      sendActivationToken({
    required String email,
  }) async {
    try {
      final body = {'email': email};
      final result = await _apiService.sendActivationToken(body);
      if (result.response.statusCode == 200) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<AuthResponse>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String activationToken,
  }) async {
    try {
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'activation_token': activationToken,
      };
      final result = await _apiService.register(body);
      if (result.response.statusCode == 200) {

        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<ResetPasswordResponse>>>
      sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      final body = {'email': email};
      final result = await _apiService.sendResetPasswordEmail(body);
      if (result.response.statusCode == 200) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }

  @override
  Future<Either<ExceptionHandler, HttpResponse<MessageResponse>>> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final body = {
        'email': email,
        'reset_token': resetToken,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
      final result = await _apiService.resetPassword(body);
      if (result.response.statusCode == 200) {
        return Right(result);
      } else {
        final errorMessage = result.response.data['detail'] as String;
        final exceptionHandler = ExceptionHandler(
          messageException: errorMessage,
        );
        return Left(exceptionHandler);
      }
    } on DioException catch (e) {
      return Left(ExceptionHandler(dioException: e));
    }
  }
}
