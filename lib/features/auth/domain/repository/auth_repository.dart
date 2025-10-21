import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<ExceptionHandler, ApiResponse<AuthResponse>>> login({
    required String email,
    required String password,
  });

  Future<Either<ExceptionHandler, ApiResponse<ActivationTokenResponse>>>
      sendActivationToken({
    required String email,
  });

  Future<Either<ExceptionHandler, ApiResponse<AuthResponse>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String activationToken,
  });

  Future<Either<ExceptionHandler, ApiResponse<dynamic>>>
      sendResetPasswordEmail({
    required String email,
  });

  Future<Either<ExceptionHandler, ApiResponse<dynamic>>> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  });

}
