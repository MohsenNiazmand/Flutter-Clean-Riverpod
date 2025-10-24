import 'package:dartz/dartz.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/features/auth/data/models/reset_password_response.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/usecase.dart';
import 'package:retrofit/dio.dart';

class SendResetPasswordEmailUseCase
    implements
        UseCase<Either<ExceptionHandler, HttpResponse<ResetPasswordResponse>>, String> {
  SendResetPasswordEmailUseCase(this._repo);

  final AuthRepository _repo;

  @override
  Future<Either<ExceptionHandler, HttpResponse<ResetPasswordResponse>>> call({
    String? params,
  }) async {
    return _repo.sendResetPasswordEmail(email: params ?? '');
  }
}
