import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/activation_code_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/auth_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/message_response.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/reset_password_response.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRepository {
  Future<Either<ExceptionHandler, HttpResponse<AuthResponse>>> login({
    required String email,
    required String password,
  });

  Future<Either<ExceptionHandler, HttpResponse<ActivationTokenResponse>>>
      sendActivationToken({
    required String email,
  });

  Future<Either<ExceptionHandler, HttpResponse<AuthResponse>>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String activationToken,
  });

  Future<Either<ExceptionHandler, HttpResponse<ResetPasswordResponse>>>
      sendResetPasswordEmail({
    required String email,
  });

  Future<Either<ExceptionHandler, HttpResponse<MessageResponse>>> resetPassword({
    required String email,
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  });

}
