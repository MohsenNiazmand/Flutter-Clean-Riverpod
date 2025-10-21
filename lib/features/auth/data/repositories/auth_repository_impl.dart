import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/services/auth_api_service.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:flutter_clean_riverpod/shared/domain/enums/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(
    this._apiService,
    this._databaseHelper,
  );

  final AuthApiService _apiService;
  final DatabaseHelper _databaseHelper;

  @override
  Future<Either<ExceptionHandler, ApiResponse<AuthResponse>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email, 'password': password};
      final result = await _apiService.login(body);
      if (result.status == ResultTypeEnum.success.value) {
        if (result.data?.postModel != null) {
          await _databaseHelper.insertPost(result.data!.postModel!);
        }
        return Right(result);
      } else {
        final errorMessage = result.message;
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
  Future<Either<ExceptionHandler, ApiResponse<ActivationTokenResponse>>>
      sendActivationToken({
    required String email,
  }) async {
    try {
      final body = {'email': email};
      final result = await _apiService.sendActivationToken(body);
      if (result.status == ResultTypeEnum.success.value) {
        return Right(result);
      } else {
        final errorMessage = result.message;
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
  Future<Either<ExceptionHandler, ApiResponse<AuthResponse>>> register({
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
      if (result.status == ResultTypeEnum.success.value) {
        if (result.data?.postModel != null) {
          await _databaseHelper.insertPost(result.data!.postModel!);
        }
        return Right(result);
      } else {
        final errorMessage = result.message;
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
  Future<Either<ExceptionHandler, ApiResponse<dynamic>>>
      sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      final body = {'email': email};
      final result = await _apiService.sendResetPasswordEmail(body);
      if (result.status == ResultTypeEnum.success.value) {
        return Right(result);
      } else {
        final errorMessage = result.message;
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
  Future<Either<ExceptionHandler, ApiResponse<dynamic>>> resetPassword({
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
      if (result.status == ResultTypeEnum.success.value) {
        return Right(result);
      } else {
        final errorMessage = result.message;
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
