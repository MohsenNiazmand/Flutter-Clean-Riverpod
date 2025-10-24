import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/message_response.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';
import 'package:retrofit/dio.dart';

class ResetPasswordUseCase
    implements
        UseCase<Either<ExceptionHandler, HttpResponse<MessageResponse>>,
            Map<String, dynamic>> {
  ResetPasswordUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, HttpResponse<MessageResponse>>> call({
    Map<String, dynamic>? params,
  }) async {
    return _repo.resetPassword(
      email: params?['email'] as String,
      resetToken: params?['reset_token'] as String,
      password: params?['password'] as String,
      passwordConfirmation: params?['password_confirmation'] as String,
    );
  }
}
